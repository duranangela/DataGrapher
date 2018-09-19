class VoterDatum < ApplicationRecord

  validates_presence_of :state
  validates_presence_of :age
  validates_presence_of :total
  validates_presence_of :registered
  validates_presence_of :voted

end
