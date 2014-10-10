require_relative 'connect'
require_relative 'models/post'
require_relative 'models/tag'
require_relative 'models/pawn'

Tag.delete_all
Post.delete_all

Tag.create!(name: 'foo')
Tag.create!(name: 'bar')
Tag.create!(name: 'baz')
Tag.create!(name: 'quux')
Tag.create!(name: 'blarg')

Post.create!(title: 'frist psot', body: 'blah blah blah', tag_ids: Tag.some_tags(2))
Post.create!(title: 'lonely post', body: 'got no tagz')

PlainPost.create!(title: 'frist psot', body: 'blah blah blah', tag_ids: Tag.some_tags(2))

Pawn.create! do |p|
  p.this_isnt_a_real_column = 'hi there'
  p.neither_is_this = 'wazzup'
  p.nope_not_this_one_either = 'lol'
end
