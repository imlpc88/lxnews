class AddPostIdToNews < ActiveRecord::Migration
  def change
    add_column :news, :post_id, :integer
  end
end
