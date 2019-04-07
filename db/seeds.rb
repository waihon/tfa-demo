# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Users:
#
waihon = User.create!(
  name: 'Waihon',
  username: 'waihon',
  email: 'waihon@example.com',
  password: 'secret'
)

mark = User.create!(
  name: 'Mark',
  username: 'mark',
  email: 'mark@example.org',
  password: 'secret'
)

jenny = User.create!(
  name: 'Jenny',
  username: 'jenny',
  email: 'jenny@example.net',
  password: 'secret'
)
