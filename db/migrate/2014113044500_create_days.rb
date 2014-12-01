class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :day_number
      t.boolean :status, default: false

      t.belongs_to :goal
      t.timestamps
  end
 end
end