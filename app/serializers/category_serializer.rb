class CategorySerializer < ActiveModel::Serializer

  cache key: 'category', expired_at: 3.hours

  has_many :posts

  attributes :id, :name, :description, :url, :api_path
end
