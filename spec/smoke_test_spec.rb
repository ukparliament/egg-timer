require 'rails_helper'

describe "smoke test", type: :system do
  it 'home page loads' do
    visit root_path
    expect(page).to have_content("The Egg Timer")
  end
end
