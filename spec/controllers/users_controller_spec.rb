require 'rails_helper'
require 'shared_methods'

RSpec.describe UsersController, type: :controller do

  include_context "shared methods"

  let(:valid_attributes) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua' } }

  let(:invalid_attributes) { {email: '', password: 'aqua', password_confirmation: 'aqua' } }

  let(:valid_session) { '' }

  describe "Sign in" do

    it "Create user and sign in" do
      User.create! valid_attributes
      valid_session = sign_in
      expect(valid_session).to be_kind_of(String)
      expect(response).to be_success
    end
  end

  describe "GET #index" do
    it "returns a success response" do
      User.create! valid_attributes
      valid_session = sign_in
      request.env['HTTP_AUTH_TOKEN'] = valid_session
      get :index, params: {}
      expect(JSON.parse(response.body)[0]['email']).to eq valid_attributes[:email]
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: {user: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_url(User.last))
      end

      it "fail a create a double new User" do
        user = User.create! valid_attributes
        post :create, params: {user: valid_attributes}
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
      let(:new_attributes) { { email: 'test2@example.com'} }

      it "updates the requested user" do
        user = User.create! valid_attributes
        valid_session = sign_in
        request.env['HTTP_AUTH_TOKEN'] = valid_session
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
        expect(user.email).to eq new_attributes[:email]
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        valid_session = sign_in
        request.env['HTTP_AUTH_TOKEN'] = valid_session
        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        valid_session = sign_in
        request.env['HTTP_AUTH_TOKEN'] = valid_session
        put :update, params: {id: user.to_param, user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      valid_session = sign_in
      request.env['HTTP_AUTH_TOKEN'] = valid_session
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
