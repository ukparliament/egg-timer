class RecessDate < ActiveRecord::Base
  
  belongs_to :house
  
  def display_description
    self.description + ' ' + self.start_date.strftime( '%Y' )
  end
end
