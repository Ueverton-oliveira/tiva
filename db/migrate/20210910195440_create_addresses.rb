class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :district
      t.string :street
      t.string :house_number
      t.references :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
