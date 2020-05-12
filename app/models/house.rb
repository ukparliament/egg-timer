class House < ActiveRecord::Base
  
  has_many :sitting_days
  has_many :adjournment_days
end
