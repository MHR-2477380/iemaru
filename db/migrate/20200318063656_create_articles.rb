class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|

    t.integer :user_id, index: true, foreign_key: true, null: false
    t.string :article_image_id
    t.string :town
    t.string :family_makeup
    t.string :maker
    t.string :sales_form
    t.string :type
    t.string :style
    t.string :purchase_price
	t.text :content
	t.timestamps
    end
  end
end
