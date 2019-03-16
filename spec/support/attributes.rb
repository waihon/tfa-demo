def user_attributes(overrides = {})
  {
    name: "Example User",
    email: "user@example.com",
    password: "secretgarden",
    password_confirmation: "secretgarden"
  }.merge(overrides)
end
