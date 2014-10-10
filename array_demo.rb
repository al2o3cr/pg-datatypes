require_relative 'seed'

puts Post.find_by(title: 'frist psot').tags.inspect

Tag.all.each do |tag|
  puts Post.tagged_with(tag.id).count
end

PlainPost.limit(10).includes(:tags).map(&:tag_ids)
