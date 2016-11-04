class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :occasion
      t.integer :invited_count
      t.datetime :date
      t.boolean :cancelled

      t.timestamps
    end
  end
end
