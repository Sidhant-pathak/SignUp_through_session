class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :post_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
