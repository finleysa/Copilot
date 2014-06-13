require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Copilot'" do
      visit '/static/home'
      expect(page).to have_content('Copilot')
    end

    it "should have the content 'Copilot'" do
      visit '/static/home'
    end
  end
end
