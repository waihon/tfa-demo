# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Users:
#
waihon = User.create!(
  name: 'Waihon',
  email: 'waihon@example.com',
  password: 'secret'
)

mark = User.create!(
  name: 'Mark',
  email: 'mark@example.org',
  password: 'extremesecret'
)

jenny = User.create!(
  name: 'Jenny',
  email: 'jenny@example.net',
  password: 'supersecret'
)
