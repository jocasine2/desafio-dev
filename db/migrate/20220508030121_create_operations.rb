class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations do |t|
      t.references :transaction_type, null: false, foreign_key: true
      t.date :date
      t.bigint :value
      t.string :CPF
      t.string :card_number
      t.timestamp :hour
      t.string :owner
      t.string :store_name

      t.timestamps
    end
  end
end
