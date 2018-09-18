require 'rails_helper'

describe 'User can see a graph' do
  context 'of population by age' do
    it 'after selecting corresponding variable' do
      visit '/'

      select 'United States', from: :location
      select 'Age', from: :stats
      click_on 'Submit'

      expect(current_path).to eq('/')
    end
  end
end
