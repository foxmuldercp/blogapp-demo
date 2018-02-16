class User < ApplicationRecord

  has_secure_password
  has_many :posts

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true

  def url
    user_path(self).remove('/api')
  end

  def api_path
    user_path(self)
  end

end
