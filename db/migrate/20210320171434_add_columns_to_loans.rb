class AddColumnsToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :outstanding_balance, :decimal, precision: 8, scale: 2
    add_column :loans, :interest, :decimal, precision: 5, scale: 2, default: 0
  end
end
