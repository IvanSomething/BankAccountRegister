# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:identification_number) { |n| "number_#{n}" }
    name { 'name' }
    surname { 'surname' }
    patronymic_name { 'patronymic_name' }
    tags_attributes { [name: 'foo'] }
  end
end
