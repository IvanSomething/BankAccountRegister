# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { '4' }
    account { nil }
    deposit { false }
  end
end
