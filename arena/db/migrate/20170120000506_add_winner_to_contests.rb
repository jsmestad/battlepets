class AddWinnerToContests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :winning_value, :integer, default: -1
  end
end
