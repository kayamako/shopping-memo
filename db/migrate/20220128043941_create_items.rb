class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.date :purchase_date
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
