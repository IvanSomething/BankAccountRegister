class Account < ApplicationRecord
  belongs_to :user
  validates :currency, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
