class AddPostImageIdToPostComments < ActiveRecord::Migration[5.2]
  def change
    add_column :post_comments, :post_comment_image_id, :string
  end
end
