require 'rails_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.around do |example|

    # Just disable the VCR, the configuration for its usage
    # will be done in a shared_context
    if example.metadata[:vcr]
      example.run
    else
      VCR.turned_off { example.run }
    end
  end
end

shared_context 'with vcr', vcr: true do
  # Disable new records on CI. Most of the CI providers
  # configure environment variable called CI.
  let(:cassette_record) { ENV['CI'] ? :none : :new_episodes }

  ap "HI"

  around do |example|
    VCR.turn_on!

    VCR.use_cassette(cassette_name, { record: cassette_record }) do
      example.run
    end

    VCR.turn_off!
  end
end

describe "record vcr for google authentication" do
  context "using vcr", vcr: true do

    class TestClass
      include Syncing::GoogleCalendar
    end

  #   pending 'can do auth' do
  #     cassette_name =  'calendar_auth'
  #     VCR.use_cassette(cassette_name, { record: :new_episodes }) do
  #       TestClass.new.authorise_calendar_access
  #     end
  #   end

    it'can get request' do
      cassette_name = "auth3"

      service = nil
      VCR.use_cassette(cassette_name, { record: :new_episodes }) do
        service = TestClass.new.authorise_calendar_access
      end

      calendar_id = "d3333dda8d0fc131f470bc145c5d6b9fedc9a449827fc3dcf485290ce123819b@group.calendar.google.com"
      page_token = ""
      cassette_name = "list_events_adjournment"
      VCR.use_cassette(cassette_name, { record: :new_episodes }) do
        pp "HI"
        events = service.list_events(
              calendar_id,
              max_results: 2500, # 2500 is the maximum Google will return per page.
              single_events: true,
              show_deleted: true,
              page_token: page_token
           #   sync_token: sync_token
         )
        pp "EVENTS"
        ap events.items
        ap events.class
        #.items

       end
    end
  end
end
