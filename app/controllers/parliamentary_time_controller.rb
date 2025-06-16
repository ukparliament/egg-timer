class ParliamentaryTimeController < ApplicationController

  def index
    @houses = House.all

    # Set a meta information for the page.
    @page_title = "Time periods"
    @description = "Parliamentary time periods."
    @crumb << { label: 'Time periods', url: nil }
    @section = 'time-periods'
  end
end
