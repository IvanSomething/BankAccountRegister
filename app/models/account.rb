class Account < ApplicationRecord
  belongs_to :user
  validates :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :currency_uniqueness
  
  private

  def currency_uniqueness
    errors.add(:currency, 'an account with this currency already exists') if user.accounts.find_by(currency: currency)
  end
end
