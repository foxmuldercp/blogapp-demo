class Category < ApplicationRecord

  has_many :posts

  validates :name, presence: true, uniqueness: true
  validates_format_of :name, :with => /\A([A-Za-z]{2,})\ ([A-Za-z]{2,})/i

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
