class AddIndexToNewsPostId < ActiveRecord::Migration
  def change
  end
  add_index :news, [:post_id]
end
