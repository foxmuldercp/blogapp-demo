class Category < ApplicationRecord

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates_format_of :name, :with => /\A([A-Za-z0-9]{2,})\ ([A-Za-z0-9]{2,})/i

  before_save :capitalize_name

  def capitalize_name
    self.name.capitalize!
  end

  def url
    category_path(self).remove('/api')
  end

  def api_path
    category_path(self)
  end

end
