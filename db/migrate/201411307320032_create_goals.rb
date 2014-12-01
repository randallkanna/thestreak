class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal_description
      t.belongs_to :user
      t.timestamps
    end
  end
end