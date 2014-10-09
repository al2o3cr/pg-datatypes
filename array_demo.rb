require_relative 'seed'

puts Post.find_by(title: 'frist psot').tags.inspect

Tag.all.each do |tag|
  puts Post.where('? = ANY(tag_ids)', tag.id).count
end
