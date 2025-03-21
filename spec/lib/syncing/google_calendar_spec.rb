require 'rails_helper'

describe "test sync using dummy class" do
  class DummyServiceClass
    def initialize(recess: false)
      @recess = recess
    end

    def list_events(calendar_id, **)
      @recess ? create_recess_days : create_other_days
    end

    private

    def create_recess_days
      item_1 = create_list_event((Date.today -1), Date.today, "Example event", 1)
      item_2 = create_list_event((Date.today - 6), (Date.today -3), "Example event 2", 2)

      Google::Apis::CalendarV3::Events.new(items: [item_1, item_2])
    end

    def create_other_days
      item_2 = create_list_event((Date.today - 2), (Date.today - 1), nil, 2)
      item_1 = create_list_event((Date.today - 1), Date.today, nil, 1)

      Google::Apis::CalendarV3::Events.new(items: [item_1, item_2])
    end

    def create_list_event(start_day, end_day, title, id)
      Google::Apis::CalendarV3::Event.new(
        id: id,
        event_type: "default",
        kind: "calendar#event",
        start: Google::Apis::CalendarV3::EventDateTime.new(date: start_day),
        end: Google::Apis::CalendarV3::EventDateTime.new(date:  end_day),
        status: "confirmed",
        summary: title
      )
    end
  end

  class DummyClass
    include Syncing::GoogleCalendar

    def initialize(recess: false)
      @recess = recess
    end

    def authorise_calendar_access
      DummyServiceClass.new(recess: @recess)
    end
  end

  let(:house)       { House.create(name: "House of Mouse") }
  let(:calendar_id) { 1 }

  before (:each) do
    pp = ParliamentPeriod.create(
      start_date: (Date.today - 50),
      end_date: (Date.today + 50),
      number: 1
    )

    Session.create(
      start_date: (Date.today - 50),
      end_date: (Date.today + 50),
      parliament_period_id: pp.id,
      number: 1
    )
  end

  it "sorts out adjournment days" do
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
  end

  it "sorts out sitting days" do
    expect { DummyClass.new(recess: false).sync_sitting_days(calendar_id, house.id) }
      .to change { SittingDay.where(house_id: house.id).count }.by(2)
  end

   it "sorts out virtual days" do
    expect { DummyClass.new(recess: false).sync_virtual_sitting_days(calendar_id, house.id) }
      .to change { VirtualSittingDay.where(house_id: house.id).count }.by(2)
  end

  it "sorts out recess dates" do
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)

    expect { DummyClass.new(recess: true).sync_recess_dates(calendar_id, house.id) }
      .to change { RecessDate.where(house_id: house.id).count }.by(2)
  end

  it "deletes virtual sitting days when there is a problem and resyncs" do
    # First we've got our VSDs set up
    expect { DummyClass.new(recess: false).sync_virtual_sitting_days(calendar_id, house.id) }
      .to change { VirtualSittingDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(0).to(1)

    # Re-run
    expect { DummyClass.new(recess: false).sync_virtual_sitting_days(calendar_id, house.id) }
      .to change { VirtualSittingDay.where(house_id: house.id).count }.by(0)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(1).to(2)

    DetailedSyncLog.first.update(successful: false, emailed: true)

    expect { DummyClass.new(recess: false).sync_virtual_sitting_days(calendar_id, house.id) }
      .to change { VirtualSittingDay.where(house_id: house.id).count }.by(-2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.by(0)

    expect { DummyClass.new(recess: false).sync_virtual_sitting_days(calendar_id, house.id) }
      .to change { VirtualSittingDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(2).to(3)
  end

  it "deletes sitting days when there is a problem and resyncs" do
    # First we've got our VSDs set up
    expect { DummyClass.new(recess: false).sync_sitting_days(calendar_id, house.id) }
      .to change { SittingDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(0).to(1)

    # Re-run
    expect { DummyClass.new(recess: false).sync_sitting_days(calendar_id, house.id) }
      .to change { SittingDay.where(house_id: house.id).count }.by(0)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(1).to(2)

    DetailedSyncLog.first.update(successful: false, emailed: true)

    expect { DummyClass.new(recess: false).sync_sitting_days(calendar_id, house.id) }
      .to change { SittingDay.where(house_id: house.id).count }.by(-2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.by(0)

    expect { DummyClass.new(recess: false).sync_sitting_days(calendar_id, house.id) }
      .to change { SittingDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(2).to(3)
  end

  it "deletes adjournment days when there is a problem and resyncs" do
    # First we've got our VSDs set up
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(0).to(1)

    # Re-run
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(1).to(2)

    DetailedSyncLog.first.update(successful: false, emailed: true)

    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(-2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.by(0)

    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(2).to(3)
  end

  it "deletes adjournment days when there is a problem and resyncs" do
    # First we've got our VSDs set up
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(0).to(1)

    # Re-run
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(1).to(2)

    DetailedSyncLog.first.update(successful: false, emailed: true)

    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(-2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.by(0)

    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(2).to(3)
  end


  it "deletes recess days when there is a problem and resyncs" do
    # Set up adjournment days first
    expect { DummyClass.new(recess: false).sync_adjournment_days(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(0).to(1)

    # First we've got our VSDs set up
    expect { DummyClass.new(recess: true).sync_recess_dates(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { RecessDate.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(1).to(2)

    # Re-run
    expect { DummyClass.new(recess: true).sync_recess_dates(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { RecessDate.where(house_id: house.id).count }.by(0)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(2).to(3)

    DetailedSyncLog.first.update(successful: false, emailed: true)

    expect { DummyClass.new(recess: true).sync_recess_dates(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { RecessDate.where(house_id: house.id).count }.by(-2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.by(0)

    expect(AdjournmentDay.where(recess_date_id: nil).count).to be 2

    expect { DummyClass.new(recess: true).sync_recess_dates(calendar_id, house.id) }
      .to change { AdjournmentDay.where(house_id: house.id).count }.by(0)
      .and change { RecessDate.where(house_id: house.id).count }.by(2)
      .and change { DetailedSyncLog.where(google_calendar_id: calendar_id).count }.from(3).to(4)

    expect(AdjournmentDay.where.not(recess_date_id: nil).count).to be 2
  end

  it "returns stuff" do
    service = DummyClass.new.authorise_calendar_access
    calendar_id = '123'
    page_token = ''

    events = service.list_events(
            calendar_id,
            max_results: 2500, # 2500 is the maximum Google will return per page.
            single_events: true,
            show_deleted: true,
            page_token: page_token
         #   sync_token: sync_token
       )
    expect(events.items.size).to be 2
  end
end
