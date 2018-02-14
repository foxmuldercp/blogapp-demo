require 'rails_helper'
require 'spec_helper'

RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "shared methods", :shared_context => :metadata do
#  before { @some_var = :some_value }
  let(:valid_attributes) { {email: 'test@example.com', password: 'aqua', password_confirmation: 'aqua' } }

  def sign_in
#    User.create! valid_attributes
    post :login, params: {user: valid_attributes}
#    binding.pry
    JSON.parse(@response.body)['token']
  end
end

RSpec.configure do |rspec|
  rspec.include_context "shared methods", :include_shared => true
end
