# == Schema Information
#
# Table name: parliament_periods
#
#  id          :integer          not null, primary key
#  number      :integer          not null
#  start_date  :date             not null
#  end_date    :date
#  wikidata_id :string(20)
#
class ParliamentPeriod < ActiveRecord::Base
  
  has_many :sessions, -> { order( 'start_date' ) }
  has_many :prorogation_periods, -> { order( 'start_date' ) }
  
  def label
    label = self.number.ordinalize + " Parliament"
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
  
  def following_parliament_period
    ParliamentPeriod.all.where( "start_date > ?", self.end_date ).order( 'start_date' ).first
  end
  
  # A method to get all periods within a Parliament, being sessions and prorogations.
  def in_parliament_periods
    
    # We create an array to hold all periods in the Parliament.
    in_parliament_periods = []
    
    # For each session in the Parlimant ...
    self.sessions.each do |session|
      
      # ... we create an in Parliament period object ...
      time_period = InParliamentPeriod.new
      time_period.type = 'session'
      time_period.id = session.id
      time_period.number = session.number
      time_period.start_date = session.start_date
      time_period.end_date = session.end_date
      time_period.citation = session.citation
      
      # ... and add it to the array.
      in_parliament_periods << time_period
    end
    
    # For each prorogation in the Parlimant ...
    self.prorogation_periods.each do |prorogation_period|
      
      # ... we create an in Parliament period object ...
      time_period = InParliamentPeriod.new
      time_period.type = 'prorogation'
      time_period.id = prorogation_period.id
      time_period.number = prorogation_period.number
      time_period.start_date = prorogation_period.start_date
      time_period.end_date = prorogation_period.end_date
      
      # ... and add it to the array.
      in_parliament_periods << time_period
    end
    
    # We sort the array by the start date of the period within the Parliament.
    in_parliament_periods.sort_by!{ |ipp| ipp.start_date }
  end
end
