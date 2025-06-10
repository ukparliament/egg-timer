# == Schema Information
#
# Table name: sessions
#
#  id                   :integer          not null, primary key
#  citation             :string(255)
#  end_date             :date
#  number               :integer          not null
#  regnal_year_citation :string(255)
#  start_date           :date             not null
#  parliament_period_id :integer          not null
#  wikidata_id          :string(20)
#
# Foreign Keys
#
#  fk_parliament_period  (parliament_period_id => parliament_periods.id)
#
class Session < ActiveRecord::Base
  
  belongs_to :parliament_period
  has_many :sitting_days, -> { order( 'start_date asc' ) }
  has_many :virtual_sitting_days, -> { order( 'start_date asc' ) }
  has_many :adjournment_days, -> { order( 'date asc' ) }
  
  def label
    label = ''
    label = self.number.to_s
    label = label + ' (' + self.start_date.strftime( '%e %B %Y' ) + ' - '
    label = label + self.end_date.strftime( '%e %B %Y' ) if self.end_date
    label = label + ')'
    label
  end
  
  def label_with_parliament
    label = self.number.ordinalize
    label += ' session of the  '
    label += self.parliament_period.number.ordinalize
    label += ' Parliament '
    label += ' (' + self.citation + ')'
    label
  end
  
  def parliament_label
    "#{self.parliament_period.number.ordinalize} Parliament"
  end
  
  def label_in_parliament
    label = "#{self.number.ordinalize} session"
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
  
  def following_session_in_parliament
    Session.all.where( "start_date > ?", self.end_date ).where( parliament_period_id: self.parliament_period_id ).order( 'start_date' ).first
  end
  
  def date_range
    # If the session has an end date create a range up to that
    if self.end_date
      ( ( self.start_date )..( self.end_date ) ).to_a
      
    # If the session has no end date - meaning it's the current session - create a range up to the final announced day
    else
      ( (self.start_date)..( self.final_announced_day ) ).to_a
    end
  end
  
  def month_range
    month_range = []
    self.date_range. each do |date|
      month_range << [date.strftime( '%B' ), date.strftime( '%m' ), date.strftime( '%Y' )]
    end
    month_range.uniq!
  end
  
  def final_announced_day
    # We need to check if there are any virtual sitting days in this session.
    # If there are virtual sitting days in this session ...
    if self.final_announced_virtual_sitting_day
      
      # ... include sitting days, adjournment days *and* virtual sitting days when attemtping to calculate the final announced day.
      final_announced_day = [self.final_announced_adjournment_day.date, self.final_announced_sitting_day.end_date, self.final_announced_virtual_sitting_day.end_date].sort.last
      
    #  If there are no virtual sitting days in this session ...
    else
      
      # ... include sitting days and adjournment days only when attemtping to calculate the final announced day.
      final_announced_day = [self.final_announced_adjournment_day.date, self.final_announced_sitting_day.end_date].sort.last
    end
    final_announced_day
  end
  
  def final_announced_sitting_day
    self.sitting_days.last
  end
  
  def final_announced_virtual_sitting_day
    self.virtual_sitting_days.last
  end
  
  def final_announced_adjournment_day
    self.adjournment_days.last
  end
end
