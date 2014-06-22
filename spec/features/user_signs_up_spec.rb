feature "User signs up" do
  scenario "happy path" do
    visit '/'
    click_link "Sign up"
    attach_file "Profile Picture", 'spec/data/Capybara.jpg'
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "joe"
    fill_in "Password", with: "mypassword"
    fill_in "Password confirmation", with: "mypassword"
    click_button "Sign up"
    page.should have_content "Welcome to Copilot!"
    page.should_not have_link("Sign up")
=begin
    click_link "Sign out"
    click_link "Sign in"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "mypassword"
    click_button "Sign in"
    page.should have_content "You have signed in successfully"
=end
  end
end
