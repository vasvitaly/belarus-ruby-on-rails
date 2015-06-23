require 'rubygems'

require 'psych'
require 'yaml'
# YAML::ENGINE.yamler = "syck" if defined?(YAML::ENGINE)

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
