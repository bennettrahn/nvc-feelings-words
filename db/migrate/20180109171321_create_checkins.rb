class CreateCheckins < ActiveRecord::Migration[5.1]
  def change
    create_table :checkins do |t|
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
