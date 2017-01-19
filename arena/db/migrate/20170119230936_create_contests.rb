class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.text :challenger
      t.text :defendant

      t.timestamps
    end
  end
end
