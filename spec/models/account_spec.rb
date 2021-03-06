# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user_attributes) do
    {
      name: 'name',
      surname: 'surname',
      patronymic_name: 'patronymic_name',
      identification_number: 1,
      tags_attributes: [{ name: 'foo' }]
    }
  end

  let(:account_attributes) do
    {
      currency: 'usd',
      amount: '0'
    }
  end

  let(:user) do
    User.create! user_attributes
  end

  let(:account) do
    user.accounts.create account_attributes
  end

  describe 'Validations' do
    it 'is valid with the required attributes' do
      expect(account).to be_valid
    end

    it 'is not valid without a currency' do
      account.currency = nil
      expect(account).not_to be_valid
    end

    it 'is not valid without a amount' do
      account.amount = -1
      expect(account).not_to be_valid
    end
  end
end
