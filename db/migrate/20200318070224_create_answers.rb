class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|

    	t.integer :user_id, index: true, foreign_key: true, null: false
    	t.integer :question_id, index: true, foreign_key: true, null: false
    	t.string :answer_image_id
    	t.text :content

    	t.timestamps
    end
  end
end
