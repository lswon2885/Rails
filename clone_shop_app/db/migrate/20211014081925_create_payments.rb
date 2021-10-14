class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.json :response
      t.string :imp_uid
      t.string :merchant_uid
      t.decimal :amount

      t.timestamps
    end
  end
end
