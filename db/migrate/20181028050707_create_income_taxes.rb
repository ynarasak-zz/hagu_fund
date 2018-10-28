class CreateIncomeTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :income_taxes do |t|
      t.integer :grade
      t.integer :over
      t.integer :under
      t.integer :tax

      t.timestamps
    end
  end
end
