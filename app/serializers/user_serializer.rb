class UserSerializer < ActiveModel::Serializer

  cache key: 'user', expired_at: 3.hours

  has_many :posts

  attributes :id, :email, :name, :posts_count, :url, :created_at, :api_path

  def posts_count
    object.posts.count
  end

end
