$VERBOSE = nil

require 'misty'
require 'minitest/autorun'
require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/integration/vcr'
  config.hook_into :webmock
end
