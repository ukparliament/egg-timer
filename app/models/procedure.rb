class Procedure < ActiveRecord::Base
  
  def active_label
    if self.active
      active_status = 'True'
    else
      active_status = 'False'
    end
  end
end
