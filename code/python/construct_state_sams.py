import pandas as pd
import numpy as np
import os

### Functions

def merge_trade(x):

    if x[:3] == "TRD":
        return "TRD"
    if x == "INVEN":
        return 'NonIndustry'
    if x == 'NIT':
        return 'FER'
    else:
        return x

def change_sector_name(sector_name):
    
    if sector_name in ['Employee Compensation']:
        return 'LAB'
    elif sector_name in ['Capital']:
        return 'CAP'
    elif sector_name in ['Other Property Type Income']:
        return 'PROP'
    elif 'Propri' in sector_name:
        return 'PROF'
    elif 'Federal Government' in sector_name:
        return 'GOV_FED'
    elif 'State/Local Govt' in sector_name:
        return 'GOV_STT'
    elif 'FederalEnt' in sector_name:
        return 'GOV_FED_ENT'
    elif 'StateLocalEnt' in sector_name:
        return 'GOV_STT_ENT'
    elif 'FedEmploy' in sector_name:
        return 'GOV_FED_EMP'
    elif 'StateLocalEmploy' in sector_name:
        return 'GOV_STT_EMP'
    elif 'inven' in sector_name.lower():
        return 'INVEN'
    elif 'Households' in sector_name:
        return 'HOH'
    elif 'corp' in sector_name.lower():
        return 'CORP'
    elif 'Not an industry' in sector_name:
        return 'OtherIND'
    elif 'energy' in sector_name.lower():
        return 'ENG'
    elif 'Agri' in sector_name:
        return 'AGR_' + sector_name.split('_')[1][0]
    elif sector_name == 'Manufacturing':
        return 'MAN'
    elif 'tax' in sector_name.lower():
        return 'TAX'
    elif 'trade' in sector_name.lower():
        return 'TRD_' + sector_name[0]
    elif 'for' == sector_name.lower():
        return 'FORE'
    else:
        return sector_name.replace(' ', '_')



### Main

## Import data

# Get list of inudstry detail files
ind_det_files = [x[2] for x in os.walk(
    '../../data/implan/industry_detail/')][0]

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
        'Year == 2016 and State == @ind_det_state').groupby(
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

    data_df_sam_raw = data_df.groupby(
        ['Sector_input', 'Sector_output']).sum()['Value'].reset_index().pivot(
        index = 'Sector_input', columns = 'Sector_output', 
        values = 'Value').fillna(0)

    # Fix sector names
    data_df['Sector_output'] = data_df['Sector_output'].apply(
        lambda x: merge_trade(change_sector_name(x)))
    data_df['Sector_input'] = data_df['Sector_input'].apply(
        lambda x: merge_trade(change_sector_name(x)))

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
    temp_sum_1 = np.sum(data_df_sam.loc[:, 'NonIndustry'])
    data_df_sam.loc['CAP', 'NonIndustry'] = 0
    data_df_sam.loc['LAB', 'NonIndustry'] = data_df_sam.loc['HOH', 
        'NonIndustry']
    data_df_sam.loc['HOH', 'NonIndustry'] = 0
    temp_sum_2 = np.sum(data_df_sam.loc[:, 'NonIndustry'])
    data_df_sam.loc['NonIndustry', :] = (temp_sum_2/temp_sum_1) * \
                                        data_df_sam.loc['NonIndustry', :]

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


    ## Bundle Biomass

    biomass_unit_scale = 1/1e6

    # create biomass sector
    data_df_sam['BIOMASS'] = 0
    data_df_sam.loc['BIOMASS', :] = 0

    # add (waste-producing sector) -> (biomass sector) links
    data_df_sam.loc['AGR_CRP', 'BIOMASS'] = (
        bioenergy_dict.get('Ag Residues', 0) * biomass_unit_scale)
    data_df_sam.loc['AGR_LIV', 'BIOMASS'] = (
        bioenergy_dict.get('Manure', 0) * biomass_unit_scale)
    data_df_sam.loc['FORE', 'BIOMASS']    = (
        bioenergy_dict.get('Forest Residues', 0) * biomass_unit_scale)

    # use biomass as input for elc_biomass
    data_df_sam.loc['BIOMASS', 'ELC_BIOMASS'] = data_df_sam['BIOMASS'].sum()

    # clean up other sources of biomass
    data_df_sam.loc['AGR_CRP', 'ELC_BIOMASS'] = 0
    data_df_sam.loc['AGR_LIV', 'ELC_BIOMASS'] = 0
    data_df_sam.loc['FORE', 'ELC_BIOMASS']    = 0


    ## Add BECCS Sector

    sectors_elc_gen = [x for x in data_df_sam.columns 
        if 'ELC' in x and 'DIST' not in x]

    beccs_rel_size = 0.01
    beccs_sector_size = data_df_sam[sectors_elc_gen].sum().sum()*beccs_rel_size

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

    output_file = ('../../data/sam/state_sams/' + ind_det_state + '_' 
        + ind_det_year + '.csv')

    data_df_sam.index.name  = ''
    data_df_sam.columns.name = ''
    data_df_sam.applymap(lambda x: np.round(x, 3)).to_csv(output_file)

    print('Processed ' + ind_det_year + ' ' + ind_det_state)