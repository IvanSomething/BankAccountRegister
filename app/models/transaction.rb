# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account
end
