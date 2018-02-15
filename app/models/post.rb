class Post < ApplicationRecord

  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy

  mount_uploader :file, AttachmentUploader
  validates :file, file_size: { less_than: 2.megabytes }
  validates_format_of :name, :with => /\A([A-Za-z]{2,})\ ([A-Za-z]{2,})/i

end
