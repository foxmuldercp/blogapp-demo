require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:valid_user) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua'} }
  let(:valid_category) { {name: 'test category', description: 'test description'} }

  let(:invalid_attributes) { {name: 'a b', description: 'test description'} }

  it "Creates a new Post" do
    user = User.create! valid_user
    category = Category.create! valid_category
    valid_attributes = { name: 'Test post', content: 'Test description', category_id: category.id, user_id: user.id }
    expect {
      Post.create(valid_attributes)
    }.to change(Post, :count).by(1)
  end

  it "Creates a new Post" do
    user = User.create! valid_user
    category = Category.create! valid_category
    valid_attributes = { name: 'Test post', content: 'Test description', category_id: category.id, user_id: user.id }
    expect {
      Post.create(invalid_attributes).errors
    }
  end

end
