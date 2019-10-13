class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
                    length: { minimum: 5, maximum: 60 }
end
