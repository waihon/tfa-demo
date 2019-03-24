def sign_in(user, options={})
  visit signin_path
  expect(current_path).to eq(signin_path)

  fill_in "Email", with: (options[:with_username] ? user.username : user.email)
  fill_in "Password", with: user.password

  click_button "Sign In"
end
