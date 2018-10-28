class RenameTypeColumnToEstimates < ActiveRecord::Migration[5.2]
  def change
    rename_column :estimates, :type, :estimate_type
  end
end
