class ProrogationPeriod < ActiveRecord::Base
  
  belongs_to :parliament_period
  
  def label
    label = ''
    label = self.number.to_s
    label = label + ' (' + self.start_date.strftime( '%e %B %Y' ) + ' - '
    label = label + self.end_date.strftime( '%e %B %Y' ) if self.end_date
    label = label + ')'
    label
  end
  
  def label_with_parliament
    label = 'Parliament '
    label = label + self.parliament_period.number.to_s
    label = label + ' Prorogation '
    label = label + self.number.to_s
    label
  end
  
  def label_in_parliament
    label = "#{self.number.ordinalize} prorogation"
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
  
  ### We want to find the session immediately preceding this prorogation.
  def preceding_session
    Session.all.where( "start_date < ?", self.start_date ).order( "start_date DESC" ).first
  end
  
  ### We want to find the session immediately following this date.
  # This method is used to determine which session papers laid in prorogation are recorded in.
  def following_session
    Session.all.where( "start_date > ?", self.start_date ).order( "start_date" ).first
  end
end
