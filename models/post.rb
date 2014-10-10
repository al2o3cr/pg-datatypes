class Post < ActiveRecord::Base
  def self.slow_tagged_with(tag_id)
    where('? = ANY(tag_ids)', tag_id)
  end

  def self.tagged_with(tag_id)
    where('tag_ids @> ARRAY[?]', tag_id)
  end

  def tags
    Tag.find(tag_ids)
  end
end
