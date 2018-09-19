class AgeGroup < ApplicationRecord

  validates_presence_of :group
  validates_presence_of :ref_num
  
end
