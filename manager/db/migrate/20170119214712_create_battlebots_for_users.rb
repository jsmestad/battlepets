class CreateBattlebotsForUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :battlebots do |t|
      t.string :name
      t.integer :user_id
    end

    add_index :battlebots, :user_id
  end
end
