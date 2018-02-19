class Comment < ApplicationRecord

  belongs_to :post

  validates :author, :content, presence: true
  validates_format_of :author, :with => /\A([A-Za-z]{2,})\ ([A-Za-z]{2,})/i

  def url
    post_comment_path(self.post, self).remove('/api')
  end

  def api_path
    post_comment_path(self.post, self)
  end

end
