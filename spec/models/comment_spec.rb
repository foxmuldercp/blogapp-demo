require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:valid_user) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua'} }
  let(:valid_category) { {name: 'test category', description: 'test description'} }
  let(:valid_comment) { {author: 'test author', content: 'test description'} }

  let(:invalid_attributes) { {name: 'a b', description: 'test description'} }

  it "Creates a new Comment" do
    user = User.create! valid_user
    category = Category.create! valid_category
    post = Post.create(name: 'Test post', content: 'Test description', category_id: category.id, user_id: user.id)
    expect {
      post.comments.create(valid_comment)
    }.to change(Comment, :count).by(1)
  end

end
