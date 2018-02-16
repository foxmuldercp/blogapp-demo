class PostSerializer < ActiveModel::Serializer

  cache key: 'post', expired_at: 3.hours

  belongs_to :user
  belongs_to :category
  has_many   :comments

  attributes :id, :name, :content, :comments_count, :created_at, :url, :api_path

  def comments_count
    object.comments.count
  end

end
