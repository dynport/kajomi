$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'mail'
require 'kajomi'
require 'json'
require 'vcr'
require 'webmock'
require 'active_support/inflector'

VCR.configure do |config|
  config.cassette_library_dir = File.join(File.dirname(__FILE__), "fixtures", "cassettes")
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
