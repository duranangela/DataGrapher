require 'rails_helper'
require 'csv'

describe 'GET /api/v1/graphs' do
  before :each do
    StateName.create(name: 'United States', abbr: 'US')
    StateName.create(name: 'Alabama', abbr: 'AL', fips: '01')
    StateName.create(name: 'Alaska', abbr: 'AK', fips: '02')
    StateName.create(name: 'Arizona', abbr: 'AZ', fips: '04')
    StateName.create(name: 'Arkansas', abbr: 'AR', fips: '05')
    StateName.create(name: 'California', abbr: 'CA', fips: '06')
    StateName.create(name: 'Colorado', abbr: 'CO', fips: '08')
    StateName.create(name: 'Connecticut', abbr: 'CT', fips: '09')
    StateName.create(name: 'Delaware', abbr: 'DE', fips: '10')
    StateName.create(name: 'District of Columbia', abbr: 'DC', fips: '11')
    StateName.create(name: 'Florida', abbr: 'FL', fips: '12')
    StateName.create(name: 'Georgia', abbr: 'GA', fips: '13')
    StateName.create(name: 'Hawaii', abbr: 'HI', fips: '15')
    StateName.create(name: 'Idaho', abbr: 'ID', fips: '16')
    StateName.create(name: 'Illinois', abbr: 'IL', fips: '17')
    StateName.create(name: 'Indiana', abbr: 'IN', fips: '18')
    StateName.create(name: 'Iowa', abbr: 'IA', fips: '19')
    StateName.create(name: 'Kansas', abbr: 'KS', fips: '20')
    StateName.create(name: 'Kentucky', abbr: 'KY', fips: '21')
    StateName.create(name: 'Louisiana', abbr: 'LA', fips: '22')
    StateName.create(name: 'Maine', abbr: 'ME', fips: '23')
    StateName.create(name: 'Maryland', abbr: 'MD', fips: '24')
    StateName.create(name: 'Massachusetts', abbr: 'MA', fips: '25')
    StateName.create(name: 'Michigan', abbr: 'MI', fips: '26')
    StateName.create(name: 'Minnesota', abbr: 'MN', fips: '27')
    StateName.create(name: 'Mississppi', abbr: 'MS', fips: '28')
    StateName.create(name: 'Missouri', abbr: 'MO', fips: '29')
    StateName.create(name: 'Montana', abbr: 'MT', fips: '30')
    StateName.create(name: 'Nebraska', abbr: 'NE', fips: '31')
    StateName.create(name: 'Nevada', abbr: 'NV', fips: '32')
    StateName.create(name: 'New Hampshire', abbr: 'NH', fips: '33')
    StateName.create(name: 'New Jersey', abbr: 'NJ', fips: '34')
    StateName.create(name: 'New Mexico', abbr: 'NM', fips: '35')
    StateName.create(name: 'New York', abbr: 'NY', fips: '36')
    StateName.create(name: 'North Carolina', abbr: 'NC', fips: '37')
    StateName.create(name: 'North Dakota', abbr: 'ND', fips: '38')
    StateName.create(name: 'Ohio', abbr: 'OH', fips: '39')
    StateName.create(name: 'Oklahoma', abbr: 'OK', fips: '40')
    StateName.create(name: 'Oregon', abbr: 'OR', fips: '41')
    StateName.create(name: 'Pennsylvania', abbr: 'PA', fips: '42')
    StateName.create(name: 'Rhode Island', abbr: 'RI', fips: '44')
    StateName.create(name: 'South Carolina', abbr: 'SC', fips: '45')
    StateName.create(name: 'South Dakota', abbr: 'SD', fips: '46')
    StateName.create(name: 'Tennessee', abbr: 'TN', fips: '47')
    StateName.create(name: 'Texas', abbr: 'TX', fips: '48')
    StateName.create(name: 'Utah', abbr: 'UT', fips: '49')
    StateName.create(name: 'Vermont', abbr: 'VT', fips: '50')
    StateName.create(name: 'Virginia', abbr: 'VA', fips: '51')
    StateName.create(name: 'Washington', abbr: 'WA', fips: '53')
    StateName.create(name: 'West Virgina', abbr: 'WV', fips: '54')
    StateName.create(name: 'Wisconsin', abbr: 'WI', fips: '55')
    StateName.create(name: 'Wyoming', abbr: 'WY', fips: '56')
    StateName.create(name: 'Puerto Rico', abbr: 'PR', fips: '72')

    AgeGroup.create(group: 'category', ref_num: 'AGEGROUP')
    AgeGroup.create(group: '0-4', ref_num: '1')
    AgeGroup.create(group: '5-9', ref_num: '2')
    AgeGroup.create(group: '10-14', ref_num: '3')
    AgeGroup.create(group: '15-19', ref_num: '4')
    AgeGroup.create(group: '20-24', ref_num: '5')
    AgeGroup.create(group: '25-29', ref_num: '6')
    AgeGroup.create(group: '30-34', ref_num: '7')
    AgeGroup.create(group: '35-39', ref_num: '8')
    AgeGroup.create(group: '40-44', ref_num: '9')
    AgeGroup.create(group: '45-49', ref_num: '10')
    AgeGroup.create(group: '50-54', ref_num: '11')
    AgeGroup.create(group: '55-59', ref_num: '12')
    AgeGroup.create(group: '60-64', ref_num: '13')
    AgeGroup.create(group: '65-69', ref_num: '14')
    AgeGroup.create(group: '70-74', ref_num: '15')
    AgeGroup.create(group: '75-79', ref_num: '16')
    AgeGroup.create(group: '80-84', ref_num: '17')
    AgeGroup.create(group: '85+', ref_num: '18')

    CSV.foreach('./db/csv/voter_data.csv', headers: true) do |voter_data|
      VoterDatum.create(state: voter_data['STATE'],
                       age: voter_data['Age'],
                       total: voter_data['Total Citizen Population'],
                       registered: voter_data['Total registered'],
                       voted: voter_data['Total voted']
                      )
    end
  end
  it 'returns formatted info for US and States' do
    location = 'United States'
    stats = 'State'

    get "/api/v1/graphs?location=#{location}&stats=#{stats}"
    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result['colors'].count).to eq(52)
    expect(result['labels'].first).to eq('Alabama')
    expect(result['pops'].first).to eq('4874747')
    expect(result['total']).to eq('323405935')
  end
  it 'returns formatted info for US and Age' do
    location = 'United States'
    stats = 'Age'

    get "/api/v1/graphs?location=#{location}&stats=#{stats}"
    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result['colors'].count).to eq(18)
    expect(result['labels'].first).to eq('0-4')
    expect(result['pops'].first).to eq('19938860')
    expect(result['total']).to eq('323405935')
  end
  it 'returns formatted info for United States and Voter Data' do
    location = 'United States'
    stats = 'Voter Data'

    get "/api/v1/graphs?location=#{location}&stats=#{stats}"
    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result['colors'].count).to eq(5)
    expect(result['labels'].first).to eq('18-24')
    expect(result['pops'].first).to eq(26913000)
    expect(result['popsb'].first).to eq(14905000)
    expect(result['popsc'].first).to eq(11560000)
    expect(result['total']).to eq(224059000)
  end
  it 'returns formatted info for Colorado and Age' do
    location = 'Colorado'
    stats = 'Age'

    get "/api/v1/graphs?location=#{location}&stats=#{stats}"
    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result['colors'].count).to eq(18)
    expect(result['labels'].first).to eq('0-4')
    expect(result['pops'].first).to eq('336207')
    expect(result['total']).to eq('5530105')
  end
  it 'returns formatted info for Colorado and Voter Data' do
    location = 'Colorado'
    stats = 'Voter Data'

    get "/api/v1/graphs?location=#{location}&stats=#{stats}"
    result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(result['colors'].count).to eq(5)
    expect(result['labels'].first).to eq('18-24')
    expect(result['pops'].first).to eq(361000)
    expect(result['popsb'].first).to eq(210000)
    expect(result['popsc'].first).to eq(177000)
    expect(result['total']).to eq(3895000)
  end
end
