require 'rspec'
require 'rspec/its'
require 'rspec/mocks'

require 'simplecov'
SimpleCov.start

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'battleships'

SPEC_ROOT = File.expand_path('..', __FILE__)
