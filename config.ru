require "bundler/setup"
Bundler.require(:default)
require 'sinatra'
require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'
require 'resque-retry'
require 'resque-retry/server'
require 'yaml'

Resque.redis = Redis.new({
  :host => !ENV['RAILS_RESQUE_REDIS'].nil? ? ENV['RAILS_RESQUE_REDIS'] : '127.0.0.1',
  :port => 25061,
  :db => 0,
  :password => ENV['RAILS_RESQUE_PASSWORD'],
  :ssl => true
})
# Resque.redis.namespace = 'resque_test'

run Rack::URLMap.new \
  "/" => Resque::Server.new