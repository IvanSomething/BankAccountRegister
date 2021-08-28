class User < ApplicationRecord
    has_many  :accounts, dependent: :destroy
    validates :name, :surname, :patronymic_name, :identification_number, presence: true
    validates :identification_number, uniqueness: true
end
