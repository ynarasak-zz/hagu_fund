class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :companies, index: true
      t.integer :no
      t.string :code
      t.string :organization
      t.string :name
      t.date :birthday
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
