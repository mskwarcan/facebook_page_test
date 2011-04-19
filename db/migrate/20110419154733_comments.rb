class Comments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :id
      t.string :post_id
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
