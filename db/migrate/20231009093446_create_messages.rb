class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

    end
  end
end
