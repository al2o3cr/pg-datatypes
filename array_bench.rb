require 'faker'
require 'benchmark/ips'
require_relative 'connect'
require_relative 'models/post'
require_relative 'models/plain_post'

ActiveRecord::Base.logger = nil

Tag.delete_all
Tagging.delete_all
Post.delete_all
PlainPost.delete_all

N_TAGS = 100
N_POSTS = 10000
N_TAGS_PER_POST = 10

Benchmark.bm(15) do |x|
  N_TAGS.times.map do |n|
    Tag.create!(name: Faker::Company.name)
  end

  $tag_ids = Tag.all.pluck(:id)

  x.report('loading posts:') do
    N_POSTS.times do |n|
      Post.create!(title: Faker::Company.catch_phrase, body: Faker::Lorem.paragraphs(5), tag_ids: $tag_ids.sample(N_TAGS_PER_POST))
    end
  end

  x.report('loading plain:') do
    N_POSTS.times do |n|
      PlainPost.create!(title: Faker::Company.catch_phrase, body: Faker::Lorem.paragraphs(5), tag_ids: $tag_ids.sample(N_TAGS_PER_POST))
    end
  end
end

puts Tagging.count

Benchmark.ips do |x|
  x.config(time: 15, warmup: 10)

  x.report("array count") { Post.tagged_with($tag_ids.sample).count }
  x.report("join count") { PlainPost.tagged_with($tag_ids.sample).count }
  x.report("array load") { Post.limit(20).map(&:tag_ids) }
  x.report("join load") { PlainPost.limit(20).map(&:tag_ids) }
  x.report("include load") { PlainPost.limit(20).includes(:tags).map(&:tag_ids) }
  x.report("array load L") { Post.limit(200).map(&:tag_ids) }
  x.report("join load L") { PlainPost.limit(200).map(&:tag_ids) }
  x.report("include load L") { PlainPost.limit(200).includes(:tags).map(&:tag_ids) }
  x.report("array load tags") { Post.limit(20).each { |p| p.tags.to_a } }
  x.report("join load tags") { PlainPost.limit(20).each { |p| p.tags.to_a } }
  x.report("include load tags") { PlainPost.limit(20).includes(:tags).each { |p| p.tags.to_a } }
end

