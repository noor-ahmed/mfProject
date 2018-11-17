class Request < ApplicationRecord
  belongs_to :user

  enum status: [ :open, :processed, :hr_reviewed ]
end
