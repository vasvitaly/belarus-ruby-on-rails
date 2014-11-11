#!/usr/bin/env ruby
require 'fileutils'

unless ARGV[0]
  puts "This script links site-specific config file and languages into config and localizations folders \n"
  puts "Please pass site folder name as first parameter. Find site-folders in config/site-specific"
  exit
end

site_name = ARGV[0]
puts config_dir = File.expand_path("../config",__FILE__)
puts site_dir = File.join(config_dir, 'site_specific', site_name)

if File.directory?(site_dir)
  puts "#{site_dir} exists"
  # puts Dir.glob("#{site_dir}/**/*.yml")
  # puts Dir.glob("#{site_dir}/**")
  Dir.glob("#{site_dir}/**/*.yml").each do |file_path|
    symlink_path = file_path.gsub(site_dir, config_dir)
    puts "symlink  #{file_path} to #{symlink_path}"
    FileUtils.ln_s file_path, symlink_path, force: true
  end
end