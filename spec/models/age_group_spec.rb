require 'rails_helper'

RSpec.describe AgeGroup, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:group)}
    it {should validate_presence_of(:ref_num)}
  end
end
