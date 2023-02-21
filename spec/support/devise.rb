RSpec.configure do |config|
  config.before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
end