require 'rails_helper'

describe "Calculation test 1", type: :system do
  context "With the seed data loaded" do
    before(:context) do
      Rails.application.load_seed
    end

    after(:context) do
      # Get all table names except schema migrations
      tables = ActiveRecord::Base.connection.tables - ['schema_migrations', 'ar_internal_metadata']

      # Truncate all tables and reset sequences
      ActiveRecord::Base.connection.execute(<<-SQL)
        TRUNCATE TABLE #{tables.join(', ')} RESTART IDENTITY CASCADE;
      SQL
    end

    it 'calculates legislative reform order - negative procedure objection correctly' do
      visit root_path
      expect(page).to have_content("egg timer")
      click_on "Scrutiny end date calculator"

      choose "Negative statutory instrument praying period (laid before Commons only)"

      fill_in 'start-date', with: "01/02/2024"
      click_on "Continue with this period and starting date"

      expect(page).to have_content("Scrutiny end date - number of days to count required")
      expect(page).to have_field('day-count', with: '40')

      click_on "Calculate"

      expect(page).to have_content("The anticipated start date of the scrutiny period is Thursday, 1 February 2024")
      expect(page).to have_content("The anticipated end date of the scrutiny period is Thursday, 21 March 2024")
    end
  end
end
