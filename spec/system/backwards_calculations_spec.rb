require 'rails_helper'
require 'support/database_support'

describe "Backward calculation tests", type: :system do
  context "With the data loaded from a database export" do
    before(:context) do
      load_sql_dump
      travel_to Time.zone.local(2025, 1, 9, 12, 00, 00)
    end

    after(:context) do
      truncate_all_data_tables
      travel_back
    end

    context "Present instrument with a future end date" do
      it "has the calendar set up" do
        visit root_path
        click_on "Calendar"
        click_on "2026"
        click_on "July"

        # Expect 1st row to have
        # Date Day       Commons Day type           Commons scrutiny day  Lords day type            Lords scrutiny day
        # 1st  Wednesday Parliamentary Sitting Day  True                  Parliamentary Sitting Day True
        first_data_row = all('table tbody tr').first
        expected_first_calendar_row = ["1st", "Wednesday", "Parliamentary sitting day", "True", "Parliamentary sitting day", "True"]

        cells = first_data_row.all('td, th').map(&:text)
        expect(cells).to match_array(expected_first_calendar_row)
      end

      it "shows the correct message" do
        visit root_path
        click_on "Calculators"
        click_on "Scrutiny start date calculator"
        fill_in 'start-date', with: "01/07/2026"
        choose "Negative statutory instrument praying period (laid before both Houses)"
        click_on "Continue with this period and end date"
        expect(find_field('day-count').value).to eq "40"
        click_on "Calculate"

        expect(page).to have_content("To produce a target end date of Wednesday, 1 July 2026, the scrutiny period is currently expected to begin on Wednesday, 13 May 2026 and end on Wednesday, 1 July 2026.")
        expect(page).to have_content("In order for the scrutiny period to start on Wednesday, 13 May 2026, the instrument must be laid on or before that date.")
      end
    end

    context "Present instrument with a future end date" do
      it "shows the correct message" do
        visit root_path
        click_on "Calculators"
        click_on "Scrutiny start date calculator"
        fill_in 'start-date', with: "01/07/2026"
        choose "Treaty objection period A"
        click_on "Continue with this period and end date"
        expect(find_field('day-count').value).to eq "21"
        click_on "Calculate"

        expect(page).to have_content("To produce a target end date of Wednesday, 1 July 2026, the scrutiny period is currently expected to begin on Wednesday, 20 May 2026 and end on Wednesday, 1 July 2026.")
        expect(page).to have_content("In order for the scrutiny period to start on Wednesday, 20 May 2026, the treaty must be laid before that date.")
      end
    end

    context "Negative statutory instrument praying period - IN THE PAST" do
      it "shows the correct message with past tense" do
        visit root_path

        click_on "Calculators"
        click_on "Scrutiny start date calculator"
        fill_in 'start-date', with: "31/03/2024"
        choose "Negative statutory instrument praying period (laid before Commons only)"
        click_on "Continue with this period and end date"
        expect(find_field('day-count').value).to eq "40"
        click_on "Calculate"

        expect(page).to have_content("To produce a target end date of Sunday, 31 March 2024, the scrutiny period is currently expected to begin on Tuesday, 6 February 2024 and end on Tuesday, 26 March 2024.")
        expect(page).to have_content("In order for the scrutiny period to start on Tuesday, 6 February 2024, the instrument would have been required to have been laid on or before that date.")
      end
    end

     context "Treaty period objective A - IN THE PAST" do
      it "shows the correct message with past tense" do
        visit root_path

        click_on "Calculators"
        click_on "Scrutiny start date calculator"
        fill_in 'start-date', with: "01/03/2025"
        choose "Treaty objection period A"
        click_on "Continue with this period and end date"
        expect(find_field('day-count').value).to eq "21"
        click_on "Calculate"

        expect(page).to have_content("To produce a target end date of Saturday, 1 March 2025, the scrutiny period is currently expected to begin on Friday, 17 January 2025 and end on Thursday, 27 February 2025.")
        expect(page).to have_content("In order for the scrutiny period to start on Friday, 17 January 2025, the treaty would have been required to have been laid before that date.")
      end
    end

     context "Made affirmative approval period (laid before both Houses, clock stops if both Houses rise) - IN THE PAST" do
      it "shows the correct message" do
        visit root_path

        click_on "Calculators"
        click_on "Scrutiny start date calculator"
        fill_in 'start-date', with: "01/04/2025"
        choose "Made affirmative approval period (laid before both Houses, clock stops if both Houses rise)"
        click_on "Continue with this period and end date"
        expect(find_field('day-count').value).to be_nil
        fill_in 'day-count', with: 28
        click_on "Calculate"

        expect(page).to have_content("To produce a target end date of Tuesday, 1 April 2025, the scrutiny period is currently expected to begin on Wednesday, 5 March 2025 and end on Tuesday, 1 April 2025.")
        expect(page).to have_content("In order for the scrutiny period to start on Wednesday, 5 March 2025, the instrument would have been required to have been made on or before that date.")
      end
    end
  end
end
