require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.post_body_formatter = :json

  config.request_headers_to_include = ['Content-Type', 'Accept']
  config.response_headers_to_include = ['Content-Type']
end

