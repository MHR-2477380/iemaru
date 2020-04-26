class RenameTypeColumnToArticles < ActiveRecord::Migration[5.2]
  def change
  	rename_column :articles, :type, :modality
  end
end
