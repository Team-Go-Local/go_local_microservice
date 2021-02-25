require 'bundler'
Bundler.require
require './config/environment'
require 'figaro/sinatra'

run MapController