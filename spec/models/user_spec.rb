require 'rails_helper'

RSpec.describe User, type: :model do

  let(:valid_attributes) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua'} }

  let(:invalid_attributes) { { none: '12345', fail: 'something wrong' } }

  it "Creates a new User" do
    expect {
      user = User.create! valid_attributes
    }.to change(User, :count).by(1)
  end

  it "User email must be unique" do
    user = User.create! valid_attributes
    expect(User.create(valid_attributes).errors.messages[:email]).to include("has already been taken")
  end

end
