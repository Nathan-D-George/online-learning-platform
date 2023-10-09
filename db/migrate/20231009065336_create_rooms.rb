class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foregin_key: true    
      
    end
  end
end
