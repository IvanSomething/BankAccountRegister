class User < ApplicationRecord
    validates :name, :surname, :patronymic_name, :identification_number, presence: true
    validates :identification_number, uniqueness: true
end
