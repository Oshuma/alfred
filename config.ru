require 'bundler/setup'

$:.push File.expand_path("../lib", __FILE__)
require 'alfred'

run Alfred::App
