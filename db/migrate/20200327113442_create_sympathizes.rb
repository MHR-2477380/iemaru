class CreateSympathizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sympathizes do |t|
      t.integer :user_id, index: true
      t.integer :question_id, index: true

      t.timestamps
    end
  end
end
