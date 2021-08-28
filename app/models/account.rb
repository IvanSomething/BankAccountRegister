class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  before_validation :set_amount

  validates :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :currency_uniqueness
  
  def to_deposit(amount)
    self.amount += amount
    true
    save!
  end

  def withdraw(amount)
    self.amount -= amount
    true
    save!
  end

  private

  def currency_uniqueness
    errors.add(:currency, 'an account with this currency already exists') if user.accounts.find_by(currency: currency)
  end

  def set_amount
    self.amount ||= 0
  end
end
