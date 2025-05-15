class AddTimeStamps < ActiveRecord::Migration[8.0]
  def change
    add_timestamps(:recess_dates, default: -> { "CURRENT_TIMESTAMP" })
    add_timestamps(:sitting_days, default: -> { "CURRENT_TIMESTAMP" })
    add_timestamps(:virtual_sitting_days, default: -> { "CURRENT_TIMESTAMP" })
    add_timestamps(:adjournment_days, default: -> { "CURRENT_TIMESTAMP" })

  end
end
