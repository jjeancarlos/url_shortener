class Link < ApplicationRecord
  belongs_to :user

  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  before_validation :generate_short_code, on: :create

  private

  def generate_short_code
    self.short_code ||= SecureRandom.alphanumeric(6)
  end
end
