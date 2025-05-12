class AddTimeStamps < ActiveRecord::Migration[8.0]
  def change
    add_timestamps(:recess_dates)
    add_timestamps(:sitting_days)
    add_timestamps(:virtual_sitting_days)
    add_timestamps(:adjournment_days)

  end
end
