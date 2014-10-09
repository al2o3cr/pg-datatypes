require_relative 'connect'

ActiveRecord::Migration.create_table :posts, force: true do |t|
  t.string :title
  t.text :body
  t.integer :tag_ids, array: true
end

ActiveRecord::Migration.create_table :tags, force: true do |t|
  t.string :name
end

ActiveRecord::Migration.create_table :taggings, force: true do |t|
  t.integer :plain_post_id
  t.integer :tag_id
end

ActiveRecord::Migration.create_table :plain_posts, force: true do |t|
  t.string :title
  t.text :body
end

ActiveRecord::Migrator.up "db/migrate"
