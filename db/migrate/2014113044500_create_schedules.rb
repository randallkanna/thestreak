class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.boolean :complete, default: false

      t.belongs_to :goal
      t.timestamps
  end
 end
end