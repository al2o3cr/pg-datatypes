require_relative 'tagging'
require_relative 'tag'

class PlainPost < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
end
