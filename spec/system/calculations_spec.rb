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

    context "Calculate end date when given start date" do
      it "calculates 'legislative reform order - negative procedure objection' correctly" do
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

      it "calculates 'Made affirmative approval period (laid before both Houses, clock stops if either House rises)' correctly" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Scrutiny end date calculator"

        choose "Made affirmative approval period (laid before both Houses, clock stops if either House rises)"

        fill_in 'start-date', with: "01/09/2019"
        click_on "Continue with this period and starting date"

        expect(page).to have_content("Scrutiny end date - number of days to count required")
        expect(find_field('day-count').value).to be_nil
        fill_in 'day-count', with: '28'

        click_on "Calculate"

        expect(page).to have_content("The anticipated start date of the scrutiny period is Tuesday, 3 September 2019")
        expect(page).to have_content("The anticipated end date of the scrutiny period is Sunday, 20 October 2019")
      end

      it "calculates 'Proposed negative statutory instrument - committee sifting period' correctly" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Scrutiny end date calculator"

        choose "Proposed negative statutory instrument - committee sifting period"

        fill_in 'start-date', with: "01/01/2025"
        click_on "Continue with this period and starting date"

        expect(page).to have_content("Scrutiny end date - number of days to count required")
        expect(page).to have_field('day-count', with: '10')

        click_on "Calculate"

        expect(page).to have_content("The anticipated start date of the scrutiny period is Monday, 6 January 2025")
        expect(page).to have_content("The anticipated end date of the scrutiny period is Monday, 20 January 2025")
      end

      it "cannot calculate 'Treaty objection period A' correctly as the calendar entries do not exist for it yet" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Scrutiny end date calculator"

        choose "Treaty objection period A"

        fill_in 'start-date', with: "01/01/2030"
        click_on "Continue with this period and starting date"

        expect(page).to have_content("Scrutiny end date - number of days to count required")
        expect(page).to have_field('day-count', with: '21')

        click_on "Calculate"

        expect(page).to have_content("Unable to find a future joint sitting day")
      end
    end
  end
end
