class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :flag
      t.string :img
      t.string :link
      t.string :mainText
      t.string :resID
      t.string :secSrcA
      t.integer :sumFrom
      t.string :summary
      t.string :title
      t.integer :type

      t.timestamps
    end
  end
end
