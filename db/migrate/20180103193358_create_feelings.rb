class CreateFeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :feelings do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
