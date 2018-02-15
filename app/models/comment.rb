class Comment < ApplicationRecord

  belongs_to :post

  validates :author, :content, presence: true
  validates_format_of :author, :with => /\A([A-Za-z]{2,})\ ([A-Za-z]{2,})/i

end
