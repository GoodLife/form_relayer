require 'form_relayer'
require 'rspec'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

def stub_view post_params
  view.stubs(:request).returns(mock('request', raw_post: post_params))
end
