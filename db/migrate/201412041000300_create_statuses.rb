class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :content
      t.belongs_to :user
      t.timestamps
  end
 end
end