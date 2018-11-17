class User < ApplicationRecord
  include Clearance::User

  ROLES = %w[general hr_executive hr_manager].freeze

  has_many :requests

  validates :name, :email, presence: true
end
