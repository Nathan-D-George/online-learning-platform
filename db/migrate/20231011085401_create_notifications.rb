class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :name
      t.integer :kind, default: 0
      t.integer :course_id, default: 0

    end
  end
end
