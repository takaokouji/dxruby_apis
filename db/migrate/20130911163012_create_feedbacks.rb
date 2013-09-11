class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :method_name
      t.integer :up
      t.integer :down

      t.timestamps
    end
    add_index :feedbacks, :method_name, unique: true
  end
end
