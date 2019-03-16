def user_attributes(overrides = {})
  {
    name: "Example User",
    username: "userware",
    email: "user@example.com",
    password: "secretgarden",
    password_confirmation: "secretgarden"
  }.merge(overrides)
end
