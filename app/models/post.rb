class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  mount_uploader :file, AttachmentUploader
  validates :file, file_size: { less_than: 2.megabytes }
end
