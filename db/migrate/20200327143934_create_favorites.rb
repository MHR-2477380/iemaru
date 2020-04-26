class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id, index: true
      t.integer :article_id, index: true

      t.timestamps
    end
  end
end
