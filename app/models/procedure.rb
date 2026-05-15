# == Schema Information
#
# Table name: procedures
#
#  id                    :integer          not null, primary key
#  active                :boolean          not null
#  display_order         :integer          not null
#  has_day_count_caveats :boolean
#  name                  :string(255)      not null
#  typical_day_count     :integer
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
