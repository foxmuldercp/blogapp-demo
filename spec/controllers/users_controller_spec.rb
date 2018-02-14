require 'rails_helper'
require 'shared_methods'

RSpec.describe UsersController, type: :controller do

  include_context "shared methods"

  let(:new_user) { {email: 'test-new@example.com', password: 'aqua', password_confirmation: 'aqua' } }

  let(:invalid_attributes) { {email: '', password: 'aqua', password_confirmation: 'aqua' } }

  before {
    sign_in
    @signedin_user = User.find_by(email: 'test@example.com')
  }

  describe "Sign in" do
    it "Create user and sign in" do
      expect(@valid_session).to be_kind_of(String)
      expect(response).to be_success
    end
  end

  describe "GET #index" do
    it "returns a success response" do
      request.env['HTTP_AUTH_TOKEN'] = @valid_session
      get :index, params: {}
      expect(JSON.parse(response.body)[0]['email']).to eq @valid_user[:email]
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: new_user}
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: {user: new_user}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_url(User.last))
      end

      it "fail a create a double new User" do
        User.create! new_user
        post :create, params: {user: new_user}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: {user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { email: 'test-update@example.com'} }

      it "updates the requested user" do
        user = User.find_by(id: @signedin_user.id)
        request.env['HTTP_AUTH_TOKEN'] = @valid_session
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
        expect(user.email).to eq new_attributes[:email]
      end

      it "renders a JSON response with the user" do
        user = User.find_by(id: @signedin_user.id)
        request.env['HTTP_AUTH_TOKEN'] = @valid_session
        put :update, params: {id: user.to_param, user: @valid_user}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        request.env['HTTP_AUTH_TOKEN'] = @valid_session
        put :update, params: {id: @signedin_user.to_param, user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      request.env['HTTP_AUTH_TOKEN'] = @valid_session
      expect {
        delete :destroy, params: {id: @signedin_user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
