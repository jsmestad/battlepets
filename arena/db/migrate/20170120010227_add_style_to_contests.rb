class AddStyleToContests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :style, :string
  end
end
