require_relative 'tag'
require_relative 'plain_post'

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :plain_post
end
