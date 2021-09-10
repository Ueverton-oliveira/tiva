class CreateProfessionals < ActiveRecord::Migration[6.0]
  def change
    create_table :professionals do |t|
      t.string :name
      t.text :description
      t.string :email
      t.string :cell_phone

      t.timestamps
    end
  end
end
