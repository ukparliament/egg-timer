# == Schema Information
#
# Table name: dissolution_periods
#
#  id         :integer          not null, primary key
#  number     :integer          not null
#  start_date :date             not null
#  end_date   :date
#
class DissolutionPeriod < ActiveRecord::Base
  
  def label
    label = 'Dissolution '
    label = label + self.number.to_s
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
end
