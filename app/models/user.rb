class User < ApplicationRecord
    validates :first_name, :last_name, :patronimic, :identification_number, :tags, presence: true
    validates :identification_number, uniqueness: true
end
