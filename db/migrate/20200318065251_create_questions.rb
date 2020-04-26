class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|

    t.integer :user_id, index: true, foreign_key: true, null: false
    t.integer :category_id, index: true, foreign_key: true, null: false
    t.string :question_image_id
    t.string :title
    t.text :content
    t.boolean :status, null: false, default: true
    t.timestamps

    end
  end
end
