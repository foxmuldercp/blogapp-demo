require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:valid_attributes) { {name: 'test category', description: 'test description'} }

  let(:invalid_attributes) { {name: 'a b', description: 'test description'} }

  it "Creates a new Category" do
    expect {
      Category.create! valid_attributes
    }.to change(Category, :count).by(1)
  end

  it "Fail create Category with invalid name" do
    expect(Category.create(invalid_attributes).errors.messages[:name]).to include("is invalid")
  end

end
