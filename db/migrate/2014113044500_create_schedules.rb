class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      # t.string :day_number
      # t.integer
      t.boolean :day_one, default: false
      t.boolean :day_two, default: false
      t.boolean :day_three, default: false
      t.boolean :day_four, default: false
      t.boolean :day_five, default: false
      t.boolean :day_six, default: false
      t.boolean :day_seven, default: false
      t.boolean :day_eight, default: false
      t.boolean :day_nine, default: false
      t.boolean :day_ten, default: false
      t.boolean :day_eleven, default: false
      t.boolean :day_twelve, default: false
      t.boolean :day_thirteen, default: false
      t.boolean :day_fourteen, default: false
      t.boolean :day_fifteen, default: false
      t.boolean :day_sixteen, default: false
      t.boolean :day_seventeen, default: false
      t.boolean :day_eighteen, default: false
      t.boolean :day_nineteen, default: false
      t.boolean :day_twenty, default: false
      t.boolean :day_twenty_one, default: false

      t.belongs_to :goal
      t.timestamps
  end
 end
end