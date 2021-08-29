# frozen_string_literal: true

class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :tags, dependent: :destroy

  accepts_nested_attributes_for :tags

  validates :name, :surname, :patronymic_name, :identification_number, presence: true
  validates :identification_number, uniqueness: true
end
