import pandas as pd
import numpy as np
import os


### Functions

def agg_beccs(index):
    
    index = int(index)
    
    if   index in range(1,11):
        return 'AGR_CRP'
    elif index in range(11,15):
        return 'AGR_LIV'
    elif (index in range(17,19) or (index in range(20,41)) or 
         (index in range(50,146)) or (index in range(154,395))):
        return 'MAN'
    elif index in range(395,518):
        return 'SER'
    elif index == 49:
        return 'ELC_DIST'
    elif index == 48:
        return 'ELC_OTHER'
    elif index == 42:
        return 'ELC_FF'
    elif index == 41:
        return 'ELC_HYDRO'
    elif index == 43:
        return 'ELC_NUC'
    elif index == 44:
        return 'ELC_SOLAR'
    elif index == 45:
        return 'ELC_WIND'
    elif index == 46:
        return 'ELC_GEO'
    elif index == 47:
        return 'ELC_BIOMASS'
    elif index in [15,16,19]:
        return 'FORE'
    elif index in range(146,154):
        return 'PAP'
    elif index in range(518,521):
        return 'GOV_FED_ENT'
    elif index in range(521,527):
        return 'GOV_STT_ENT'
    elif index in [535, 536]:
        return 'GOV_FED_EMP'
    elif index in range(531, 535):
        return 'GOV_STT_EMP'
    elif index in range(527, 531):
        return 'NonIndustry'
    elif index == 5001:
        return 'LAB'
    elif index == 6001:
        return 'PROF'
    elif index == 7001:
        return 'PROP'
    elif index == 8001:
        return 'TAX'
    elif index in range(10000,11000):
        return 'HOH'
    elif index in range(11000,12000):
        return 'GOV_FED'
    elif index in range(12000,13000):
        return 'GOV_STT'
    elif index == 13001:
        return 'CORP'
    elif index in [14001, 14002]:
        return 'CAP'
    elif index in [25001, 28001]:
        return 'TRD'
    else:
        raise ValueError('Unknown index:', index)



### Main

# Output folder
output_folder = '../../data/sam/state_sams/'

## Import data

# Get list of inudstry detail files
ind_det_files = [x[2] for x in os.walk(
    '../../data/implan/industry_detail/')][0]


## Get average price of electricity in each state

# Import data
elc_pr_df = pd.read_csv('../../data/electricity/avg_elec_price.csv')

# Get composite price for all sectors
elc_pr_df = elc_pr_df.query('Sector == " all sectors"')

# Transpose data frame
elc_pr_df = elc_pr_df.set_index('State Name').T

# Get average price across all months
elc_pr_df   = elc_pr_df.drop(['Sector', 'units', 'source key'], axis = 0)
elc_pr_dict = elc_pr_df.mean().to_dict()


## Construct SAM for each file

for ind_det_file in ind_det_files:

    data_df = pd.read_csv('../../data/implan/industry_detail/' + ind_det_file, 
        skiprows = 1)
    ind_det_state = ' '.join(ind_det_file.split(' ')[:-7])
    ind_det_year  = ind_det_file.split(' ')[-7]

    # Biowaste production data
    bio_prod_df = pd.read_excel('../../data/bioenergy/bioenergy_clean.xlsx')

    # Biowaste energy data
    bio_energy_df = pd.read_excel(
        '../../data/bioenergy/bioenergy_conversion_rates.xlsx')


    ## Compute Bioenergy Availability

    # Get bioenergy of each feed stock
    bio_energy_df['kWh/dt'] = bio_energy_df['kWh/tonne']/10
    bio_energy_dict = bio_energy_df[['Feedstock', 'kWh/dt']].set_index(
        'Feedstock').fillna(0).to_dict()['kWh/dt']

    # Include it in biowaste production data frame
    bio_prod_df['feedstock_energy'] = bio_prod_df['Feedstock'].apply(
        lambda x: bio_energy_dict.get(x))

    # Subset production to northeast states in 2016 and
    # get average production for each feedstock across scenarios
    bioenergy_ne_df = bio_prod_df.query(
        'Year == @ind_det_year and State == @ind_det_state').groupby(
            ['Resource Type', 'Feedstock', 'State']).mean().groupby(
                ['Resource Type', 'Feedstock']).sum().reset_index()

    # Compute bioenergy from production of each feedstock
    bioenergy_ne_df['bioenergy'] = bioenergy_ne_df['Production'] * \
        bioenergy_ne_df['feedstock_energy']

    # Get total bioenergy for each resource type
    bioenergy_dict = bioenergy_ne_df.groupby(
        ['Resource Type'])['bioenergy'].sum().to_dict()

    # Biomass production table
    biomass_prod = bioenergy_ne_df.groupby(
        ['Resource Type', 'Feedstock'])['Production'].first().reset_index()
    biomass_prod['Production'] = biomass_prod['Production'].apply(
        lambda x: '{:,}'.format(int(np.round(x,0))))


    ## Prepare IMPLAN Entries

    data_df.columns = ['Index', 'Sector_output', 'TypeCode', 
        'Sector_input', 'Value']

    # Fix sector names
    data_df['Sector_input']  = data_df['TypeCode'].apply(lambda x: agg_beccs(x))
    data_df['Sector_output'] = data_df['Index'].apply(lambda x: agg_beccs(x))

    # Reaggregate sectors
    data_df = data_df.groupby(
        ['Sector_input', 'Sector_output']).sum()['Value'].reset_index()

    # Pivot into SAM
    data_df_sam = data_df.pivot(index = 'Sector_input', 
        columns = 'Sector_output', values = 'Value').fillna(0)

    # Remove self transfers for government and households
    data_df_sam.loc['GOV_FED', 'GOV_FED'] = 0
    data_df_sam.loc['GOV_STT', 'GOV_STT'] = 0
    data_df_sam.loc['HOH', 'HOH'] = 0

    # Change NonIndustry Inputs/Outputs so it can be modelled as a good
    if 'NonIndustry' in data_df_sam.index:
        if data_df_sam.loc['NonIndustry', :].sum() != 0:
            temp_sum_1 = np.sum(data_df_sam.loc[:, 'NonIndustry'])
            data_df_sam.loc['CAP', 'NonIndustry'] = 0
            data_df_sam.loc['LAB', 'NonIndustry'] = \
                data_df_sam.loc['HOH', 'NonIndustry']
            data_df_sam.loc['HOH', 'NonIndustry'] = 0
            temp_sum_2 = np.sum(data_df_sam.loc[:, 'NonIndustry'])
            data_df_sam.loc['NonIndustry'] = ((temp_sum_2 / temp_sum_1) * 
                                            data_df_sam.loc['NonIndustry', :])
    else:
        data_df_sam.loc['NonIndustry', :] = 0

    # Remove direct tax from goods to government
    institutions = ['CAP', 'CORP', 'GOV_FED', 'GOV_STT', 'HOH', 
        'LAB', 'PROF', 'PROP', 'TAX', 'TRD']
    goods = [x for x in data_df_sam.columns if x not in institutions]
    for i in goods:
        for g in ['GOV_FED', 'GOV_STT']:
            data_df_sam.loc['TAX', i] = data_df_sam.loc['TAX', i] + \
                                            data_df_sam.loc[g, i]
            data_df_sam.loc[g, i] = 0

    # Remove small entries
    data_df_sam = data_df_sam.applymap(lambda x: 0 if x < 1 else x)

    # Add empty electricity sectors if they don't exist
    elc_sectors = ['ELC_BIOMASS', 'ELC_HYDRO', 'ELC_NUC', 'ELC_OTHER', 
        'ELC_SOLAR', 'ELC_WIND', 'ELC_FF', 'ELC_GEO']
    for sec in elc_sectors:
        if sec not in list(data_df_sam.index):
            data_df_sam.loc[sec, :] = 0
            data_df_sam.loc[:, sec] = 0


    ## Bundle Biomass

    # Conversion from bioenergy waste unit to SAM unit 
    biomass_unit_scale = 1/1e6

    # Create biomass sector
    data_df_sam['BIOMASS'] = 0
    data_df_sam.loc['BIOMASS', :] = 0

    # Add (waste-producing sector) -> (biomass sector) links
    data_df_sam.loc['AGR_CRP', 'BIOMASS'] = (biomass_unit_scale *
        bioenergy_dict.get('Ag Residues', 0))
    data_df_sam.loc['AGR_LIV', 'BIOMASS'] = (biomass_unit_scale *
        bioenergy_dict.get('Manure', 0))
    data_df_sam.loc['FORE', 'BIOMASS']    = (biomass_unit_scale *
        bioenergy_dict.get('Forest Residues', 0))

    # Use biomass as input for elc_biomass
    data_df_sam.loc['BIOMASS', 'ELC_BIOMASS'] = data_df_sam['BIOMASS'].sum()

    # Clean up other sources of biomass (only need to zero out AGR_LIV)
    data_df_sam.loc['AGR_LIV', 'ELC_BIOMASS'] = 0


    ## Add BECCS Sector

    # Get list of existing electricity production sectors
    sectors_elc_gen = [x for x in data_df_sam.columns 
        if 'ELC' in x and 'DIST' not in x]

    # Set BECCS Sector size (in $ mil) is equal to the scale factor ($/kWh) 
    # times the total biowaste energy available to the state
    # times an efficiency factor

    # Scale factor is set to the average price of electricity in the state
    beccs_scl_fac = elc_pr_dict.get(ind_det_state, 0.10)/100 * (1e-6)
    beccs_eff_fac = 0.75
    beccs_sector_size = (data_df_sam[sectors_elc_gen].sum().sum() 
                        * beccs_scl_fac * beccs_eff_fac)
    
    # Create beccs sector from elc sectors
    data_df_sam['ELC_BECCS']        = data_df_sam.loc[:, sectors_elc_gen].sum(
        axis = 1)
    data_df_sam.loc['ELC_BECCS', :] = data_df_sam.loc[sectors_elc_gen, :].sum(
        axis = 0)

    # Remove dependencies on other elc sectors
    data_df_sam.loc['ELC_BECCS', sectors_elc_gen] = 0
    data_df_sam.loc[sectors_elc_gen, 'ELC_BECCS'] = 0

    # Add dependency on biomass
    data_df_sam.loc['BIOMASS', 'ELC_BECCS'] = beccs_sector_size * 0.2

    # Remove imports of this technology
    data_df_sam.loc['TRD', 'ELC_BECCS'] = 0

    # Scale sector
    data_df_sam.loc[:, 'ELC_BECCS'] = (data_df_sam.loc[:, 'ELC_BECCS']
        * (beccs_sector_size/data_df_sam.loc[:, 'ELC_BECCS'].sum()))
    data_df_sam.loc['ELC_BECCS', :] = (data_df_sam.loc['ELC_BECCS', :]
        * (beccs_sector_size/data_df_sam.loc['ELC_BECCS', :].sum()))


    ## Bundle Renewable Sector

    renewable_sectors = ['ELC_BIOMASS', 'ELC_HYDRO', 'ELC_NUC', 
        'ELC_OTHER', 'ELC_SOLAR', 'ELC_WIND', 'ELC_GEO']

    # Create renewable bundle
    data_df_sam['ELC_RNW'] = 0
    data_df_sam.loc['ELC_RNW', :] = 0

    # Move renewable output from dist to bundle
    for rs in renewable_sectors:
        
        # Collect renewable output into other renewables and dist
        renewable_output = 0
        for rs2 in renewable_sectors:
            renewable_output = renewable_output + data_df_sam.loc[rs, rs2] 
            data_df_sam.loc[rs, rs2] = 0

        # Move to renewable bundle
        data_df_sam.loc[rs, 'ELC_RNW'] = (renewable_output 
            + data_df_sam.loc[rs, 'ELC_DIST'])
        data_df_sam.loc[rs, 'ELC_DIST'] = 0
        
        # Move taxes to renewable bundle
        data_df_sam.loc['TAX', 'ELC_RNW'] = data_df_sam.loc['TAX', rs]
        data_df_sam.loc['TAX', rs] = 0

    # Add some factor inputs to bundle for balancing
    factors = ['LAB', 'PROP', 'PROF']

    for fac in factors:
        data_df_sam.loc[fac, 'ELC_RNW'] = data_df_sam.loc[fac, 'ELC_DIST']*0.01
        
    # Balance bundle output
    data_df_sam.loc['ELC_RNW', 'ELC_DIST'] = data_df_sam['ELC_RNW'].sum()


    ## Export 

    output_file = (output_folder + ind_det_state + '_' 
        + ind_det_year + '.csv')

    data_df_sam.index.name  = ''
    data_df_sam.columns.name = ''
    data_df_sam.applymap(lambda x: np.round(x, 3)).to_csv(output_file)

    print('Processed ' + ind_det_year + ' ' + ind_det_state)