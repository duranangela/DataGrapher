require 'rails_helper'

describe 'User can see a graph' do
  context 'of population by age' do
    before :each do
      state1 = StateName.create(name: 'United States', abbr: 'US')
      state2 = StateName.create(name: 'Colorado', abbr: 'CO', fips: '08')
    end
    it 'after selecting corresponding variable' do
      visit '/'

      within ('.select1') do
        select 'United States', from: 'location'
        click_on 'Submit'
      end

      within ('.select2') do
        select 'Age', from: 'stats1'
        click_on 'Submit'
      end

      expect(current_path).to eq('/')

      click_on 'Reset for new query'

      within ('.select1') do
        select 'Colorado', from: 'location'
        click_on 'Submit'
      end

      within ('.select3') do
        select 'Voter Data', from: 'stats2'
        click_on 'Submit'
      end

      expect(current_path).to eq('/')

    end
  end
end
