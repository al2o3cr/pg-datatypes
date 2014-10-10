require_relative 'tagging'
require_relative 'tag'

class PlainPost < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(tag_id)
    joins(:taggings).where(taggings: { tag_id: tag_id })
  end
end
