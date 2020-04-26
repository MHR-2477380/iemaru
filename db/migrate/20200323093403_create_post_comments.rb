class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.integer :user_id, index: true
      t.integer :article_id, index: true

      t.timestamps
    end
  end
end
