require 'rails_helper'

describe "Forward calculation tests", type: :system do
  context "With the seed data loaded" do
    before(:context) do
      CalculationsTestData::Manager.load
    end

    after(:context) do
      CalculationsTestData::Manager.delete
    end

    context "Recess date checker" do
      it "the checker shows there are no errors" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "About this website"
        click_on "Librarian tools"
        click_on "Recess date checker"

        expect(page).to have_content("Checking that all days in upcoming recesses are marked as adjournment days.")
        expect(page).to have_content("No errors found.")
      end
    end

    context "Parliaments" do
      it "can show the sessions and prorogations for the 59th parliament" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Parliaments"
        click_on "59th Parliament"
        within("section#sessions-and-prorogations") do
          expect(page).to have_content("1st session")
          expect(page).to have_content("9 July 2024")
        end

        within("section#sessions") do
          expect(page).to have_content("1st session")
          expect(page).to have_content("9 July 2024")
        end
      end
    end

    context "Sitting interval days" do
      it "can calculate for the whole of 2024 correctly" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Sitting days during an interval calculator"

        fill_in 'start-date', with: "01/01/2024"
        fill_in 'end-date', with: "31/12/2024"

        click_on "Calculate"

        expect(page).to have_content("143 sitting days in the House of Commons")
        expect(page).to have_content("148 sitting days in the House of Lords")

      end
    end

    context "Calculate end date when given start date" do
      it "calculates 'legislative reform order - negative procedure objection' correctly" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Scrutiny end date calculator"

        choose "Legislative reform order and Localism order - negative procedure objection period"

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
    end

    context "Show error message when there is not enough data" do

      it "cannot calculate 'Treaty objection period A' correctly as the calendar entries do not exist for it yet" do
        visit root_path
        expect(page).to have_content("egg timer")
        click_on "Scrutiny end date calculator"

        choose "Treaty objection period A"

        # We want there to be no data for this date, add a month on for good measure
        fill_in 'start-date', with: (RecessDate.order(:end_date).last.end_date + 1.month).to_s
        click_on "Continue with this period and starting date"

        expect(page).to have_content("Scrutiny end date - number of days to count required")
        expect(page).to have_field('day-count', with: '21')

        click_on "Calculate"

        expect(page).to have_content("Unable to find a future joint sitting day")
      end
    end
  end
end
