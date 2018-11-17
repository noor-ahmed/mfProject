class User < ApplicationRecord
  include Clearance::User
  has_many :requests

  ROLES = %w[general hr_executive hr_manager].freeze
  enum role: [ :general, :hr_executive, :hr_manager ]

  validates :name, presence: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@misfit\.com\z/, message: "must be a misfit.com account" }
end
