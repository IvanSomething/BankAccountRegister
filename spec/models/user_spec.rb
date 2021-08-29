require 'rails_helper'

RSpec.describe User, type: :model do
  let(:tags_attributes){[{name: 'foo'}]}
  let(:user) do
    described_class.new(
      name: 'name',
      surname: 'surname',
      patronymic_name: 'patronymic_name',
      identification_number: 1, 
      tags_attributes: tags_attributes
    )
  end

  describe 'Validations' do
    it 'is valid with the required attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without a surname' do
      user.surname = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without a patronymic_name' do
      user.patronimic = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without an identification number' do
      user.identification_number = nil
      expect(user).not_to be_valid
    end
  end
end
