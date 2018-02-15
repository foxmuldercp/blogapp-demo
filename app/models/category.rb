class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates_format_of :name, :with => /\A([A-Za-z]{2,})\ ([A-Za-z]{2,})/i

  before_save :capitalize_name

  def capitalize_name
    self.name.capitalize!
  end

end
