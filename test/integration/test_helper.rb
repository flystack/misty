require "misty"
require 'minitest/autorun'
require 'vcr'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = "test/integration/vcr"
  config.hook_into :webmock
end

def auth
  {
    :url      => "http://192.0.2.21:5000",
    :user     => "admin",
    :password => "CJk9hb2ZFR96Ypu74KFFGWuhv",
    :project  => "admin",
    :domain   => "default"
  }
end
