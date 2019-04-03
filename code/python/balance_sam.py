import pandas as pd
import os
import numpy as np
from scipy import optimize

### Functions

def RAS_step(row_totals, col_totals, seed_values, zero_cutoff = 1e-3):

        # Initial conditions
        assert type(row_totals)  == np.ndarray
        assert type(col_totals)  == np.ndarray
        assert sum(row_totals)   == sum(col_totals)

        # Initialize the matrix
        matrix = seed_values.copy()
        assert type(matrix)    == np.ndarray
        assert matrix.shape[0] == len(row_totals)
        assert matrix.shape[1] == len(col_totals)
        
        # Row update
        row_scalars = matrix.sum(axis=1) / row_totals
        matrix = (matrix.T / row_scalars).T

        # Column update
        col_scalars = matrix.sum(axis=0) / col_totals
        matrix = (matrix / col_scalars)

        # Return
        return matrix

def vec_to_sam(B):
    
    n = len(sam_mat)
    sam_B = np.zeros((n,n))
    sam_B[sam_mat != 0] = B
    
    return np.matrix(sam_B)

def kl_divergence(B):
    
    mat_a = sam_mat.copy()
    mat_b = vec_to_sam(B)
    
    # Divide matrices where we don't have zeros
    mat_div = np.divide(mat_b, mat_a, where = ((mat_a*100).astype(int) != 0))
    
    # Replace 0's with 1's which will become 0's when logged
    mat_div[np.where((mat_a*100).astype(int) == 0)] = 1
    mat_div[mat_div == 0] = 1
    
    return np.power(np.sum(np.multiply(mat_b, np.log(mat_div))), 2)

def row_col_constraint(B):    
    
    sam = vec_to_sam(B)
    
    # Row and column totals
    totals_0 = np.sum(sam, axis = 0).T
    totals_1 = np.sum(sam, axis = 1)
    
    # Divide sums where we don't have zeros
    sum_div = np.divide(totals_0, totals_1, where = totals_0 != 0)
    
    # Replace 0's with 1's
    sum_div[np.where((sum_div*100).astype(int) == 0)] = 1
    sum_div[sum_div == 0] = 1
    
    # Find total squared deviation from equality    
    return np.sum(np.square(np.multiply(sum_div-1, 100)))

def row_col_constraint_sums(B): 
    
    sam = vec_to_sam(B)
    
    # Row and column totals
    totals_0 = np.sum(sam, axis = 0).T
    totals_1 = np.sum(sam, axis = 1)
    
    # Find total squared deviation from equality    
    return np.sum(np.square(totals_0-totals_1))


### Main

## Get unbalanced SAM files
sam_files = [x[2] for x in os.walk('../../data/sam/state_sams/')][0]


for sam_file in sam_files:

    ## Import SAM file
    sam_state = '_'.join(sam_file.split('_')[:-1])
    sam_year  = sam_file.split('.')[0].split('_')[-1]
    sam_df_original = pd.read_csv('../../data/sam/state_sams/' + sam_file, 
                                  index_col = 0)
    print('Balancing {0} - {1}'.format(sam_state.replace('_', ' '),
                                       sam_year))


    ## Clean up SAM

    # Create a variant of sam df for balancing
    sam_df = sam_df_original.copy()

    # Adjust biomass sector size (speeds up balancing)
    if sam_df.loc[:,'BIOMASS'].sum() > 0:
        sam_df.loc[:,'BIOMASS'] = sam_df.loc[:,'BIOMASS']*(sam_df.loc['BIOMASS',:].sum()/sam_df.loc[:,'BIOMASS'].sum())

    # Drop zero rows and columns
    zero_sectors = list(sam_df.sum(axis=0)[sam_df.sum(axis=0) == 0].keys())
    sam_df = sam_df.drop(zero_sectors, axis = 0).drop(zero_sectors, axis = 1)

    # Sort columns and index
    sam_df = sam_df.reindex(sorted(sam_df.columns), axis=1).reindex(
                    sorted(sam_df.index), axis=0)

    # Ensure no remaining col/row sums are zero
    assert ~np.any(sam_df.sum(axis=0)==0) 
    assert ~np.any(sam_df.sum(axis=1)==0) 
        
    # Generate matrix from sam
    sam_mat = np.matrix(sam_df)


    ## Initial Guess: RAS
    sam_mat_temp = np.array(sam_df).copy()
    target_sum   = np.array((np.array(sam_mat_temp.sum(axis = 0).T).flatten() + 
                             np.array(sam_mat_temp.sum(axis = 1)).flatten())/2)

    # RAS iterations
    for i in range(10):
        sam_mat_temp = np.array(RAS_step(target_sum.copy(), target_sum.copy(), 
                                seed_values = sam_mat_temp.copy()))
    
    # Ensure original zero entries are still zero
    true_zero_idx = np.where(np.matrix(sam_df) < 0.01)
    assert len(np.where(sam_mat_temp[true_zero_idx] != 0)[0]) == 0

    # Ensure no entries became zero after balancing
    not_zero_idx = np.where(np.matrix(sam_df) > 0.01)
    assert len(np.where(sam_mat_temp[not_zero_idx] == 0)[0]) == 0


    ## Balancing: Cross Entropy
    # With an initial guess being sam_mat_temp
    B = sam_mat_temp[sam_mat_temp != 0]

    # Reconvert B to a matrix
    sam_B = vec_to_sam(B)

    # Check that its the same as the matrix it came from
    assert np.mean(sam_B - sam_mat_temp) == 0

    # Bound all values to positives
    bound_array = np.array([(0.0001,np.max(np.max(sam_df))*2)]*(len(B)))

    # Constraints
    con_1 = optimize.NonlinearConstraint(row_col_constraint,      
                                         0, row_col_constraint(B)*1)
    con_2 = optimize.NonlinearConstraint(row_col_constraint_sums, 
                                         0, row_col_constraint_sums(B)*1)

    # Optimize
    result = optimize.minimize(kl_divergence, B, 
                           constraints = (con_1, con_2), bounds = bound_array,
                           options = {'disp': False})

    # Check for balancing success 
    tol = 0.1 + 1
    if not (result.success and (kl_divergence(result.x) <= kl_divergence(B)) 
        and (row_col_constraint(result.x) <= row_col_constraint(B)*tol) and 
        (row_col_constraint_sums(result.x) <= row_col_constraint_sums(B)*tol)):

        print('Objective and Constraint Values Before Optimization')
        print('KL Divergence:      {0:20.5f}'.format(kl_divergence(B)))
        print('Row Col Cons:       {0:20.5f}'.format(row_col_constraint(B)))
        print('Row Col Sums Cons:  {0:20.5f}'.format(row_col_constraint_sums(B)))
        
        print('Objective and Constraint Values After Optimization')
        print('KL Divergence:      {0:20.5f}'.format(kl_divergence(result.x)))
        print('Row Col Cons:       {0:20.5f}'.format(
            row_col_constraint(result.x)))
        print('Row Col Sums Cons:  {0:20.5f}'.format(
            row_col_constraint_sums(result.x)))
        
        print('Change in Objective and Constraint Values')
        print('Change in KL Divergence:      {0:+10.4%}'.format(
            (kl_divergence(result.x)/kl_divergence(B)) - 1 + 1e-6))
        print('Change in Row Col Cons:       {0:+10.4%}'.format(
            (row_col_constraint(result.x)/row_col_constraint(B)) - 1 + 1e-6))
        print('Change in Row Col Sums Cons:  {0:+10.4%}'.format(
            (row_col_constraint_sums(result.x)/row_col_constraint_sums(B)) 
            - 1 + 1e-6))
        
        raise Exception('Error balancing SAM for {0} - {1}'.format(
            sam_state.replace('_', ' '), sam_year))


    ## Export Data

    # Convert to dataframe
    sam_balanced_df = pd.DataFrame(vec_to_sam(result.x), columns = sam_df.columns, index = sam_df.index)

    # Add zero sectors back in
    for sec in zero_sectors:
        sam_balanced_df.loc[sec,:] = 0
        sam_balanced_df.loc[:,sec] = 0

    # Construct pivotted version of balanced sam
    sam_bal_pivot_df              = sam_balanced_df.reset_index().melt(
        id_vars = 'index', value_vars = sam_balanced_df.columns)
    sam_bal_pivot_df.columns      = ['ExportingSector', 'ImportingSector', 
        'TransferAmount']
    sam_bal_pivot_df['Region']    =  'USA'
    sam_bal_pivot_df['SubRegion'] = sam_state.replace('_', ' ')
    sam_bal_pivot_df['SubRegion'] = sam_year

    # Export to csv
    sam_bal_pivot_df.to_csv('../../data/sam/balanced/{0}_{1}.csv'.format(
        sam_state, sam_year), index = False)