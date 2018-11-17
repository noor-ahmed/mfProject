class Request < ApplicationRecord
  belongs_to :user
  enum status: [ :open, :processed, :hr_reviewed ]
  before_create :set_status
  validates :description, :status, presence: true

  private
  def set_status
    status = 'open'
  end
end
