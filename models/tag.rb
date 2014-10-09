require_relative 'tagging'
require_relative 'plain_post'

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :plain_posts, through: :taggings

  def self.some_tags(n)
    self.pluck(:id).sample(n)
  end
end
