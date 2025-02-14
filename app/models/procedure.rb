# == Schema Information
#
# Table name: procedures
#
#  id                    :integer          not null, primary key
#  display_order         :integer          not null
#  name                  :string(255)      not null
#  active                :boolean          not null
#  typical_day_count     :integer
#  has_day_count_caveats :boolean
#
class Procedure < ActiveRecord::Base
  
  def active_label
    if self.active
      active_status = 'True'
    else
      active_status = 'False'
    end
  end
  
  def status_label
  	self.active ? "Hide" : "Show"
  end
end
