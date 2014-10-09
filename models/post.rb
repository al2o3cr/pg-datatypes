class Post < ActiveRecord::Base
  def tags
    Tag.find(tag_ids)
  end
end
