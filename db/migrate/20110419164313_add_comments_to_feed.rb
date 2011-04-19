class AddCommentsToFeed < ActiveRecord::Migration
  def self.up
    drop_table :comments
    add_column :feeds, :comments, :text
  end

  def self.down
    create_table :comments do |t|
      t.string :id
      t.string :post_id
      t.string :comments

      t.timestamps
    end
    remove_column :feeds, :comments
  end
end
