require 'rails_helper'
require 'jwt'

RSpec.describe PostsController, type: :controller do

  let(:valid_user) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua' } }

  let(:invalid_attributes) { {email: '', password: 'aqua' } }

  before {
    @category = Category.create(name: 'Test category', description: 'Test category description')
    @valid_user = User.create(valid_user)
    @valid_attributes = { name: 'Test post', content: 'Test description', category_id: @category.id, user_id: @valid_user.id }
    @post = Post.create(@valid_attributes)
    token = JsonWebToken.encode(@valid_user.slice(:id, :name, :email))
    request.env['HTTP_AUTH_TOKEN'] = token
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: @post.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do

      it "creates a new Post" do
        expect {
          post :create, params: {post: @valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post :create, params: {post: @valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(post_url(Post.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new post" do
        post :create, params: {post: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Updated name' } }

      it "updates the requested post" do
        put :update, params: {id: @post.to_param, post: new_attributes}
        @post.reload
        expect(@post.name).to eq new_attributes[:name].capitalize
      end

      it "renders a JSON response with the post" do
        put :update, params: {id: @post.to_param, post: @valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the post" do
        put :update, params: {id: @post.to_param, post: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, params: {id: @post.to_param}
      }.to change(Post, :count).by(-1)
    end
  end

end
