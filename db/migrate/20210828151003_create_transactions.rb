# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :account, null: false, foreign_key: true
      t.integer :deposit, null: false

      t.timestamps
    end
  end
end
