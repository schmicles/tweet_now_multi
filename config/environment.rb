# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'

if development?
  require "sinatra/reloader"
  require 'byebug'
end

require 'erb'
require 'twitter'
require 'yaml'
require 'awesome_print'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

API_KEYS = YAML::load(File.open('config/api_rahsia.yaml'))

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = API_KEYS["development"]["consumer_key_id"]
  config.consumer_secret     = API_KEYS["development"]["consumer_secret_key_id"]
  config.access_token        = API_KEYS["development"]["access_token"]
  config.access_token_secret = API_KEYS["development"]["access_token_secret"]
  end