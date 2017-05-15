class AddSubcategoryIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :subcategory, foreign_key: true
  end
end
