require 'rails_helper'

RSpec.describe VoterDatum, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:age)}
    it {should validate_presence_of(:total)}
    it {should validate_presence_of(:registered)}
    it {should validate_presence_of(:voted)}
  end
end
