class RecessDate < ActiveRecord::Base
  
  belongs_to :house
  has_many :adjournment_days
  
  def display_description
    self.description + ' ' + self.start_date.strftime( '%Y' )
  end
end
