class CommentSerializer < ActiveModel::Serializer

  cache key: 'comment', expired_at: 3.hours

  belongs_to :post

  attributes :id, :author, :content, :url, :api_path, :created_at
end
