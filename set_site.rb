#!/usr/bin/env ruby
require 'fileutils'


unless ARGV[0]
  puts "Please pass site name as first parameter ./set_site.rb :site_name. Site-name is a folder name in config/site-specific"
  exit
end

site_name = ARGV[0]
root = File.expand_path('../', __FILE__)
puts config_dir = File.join(root, "config")
puts site_dir = File.join(config_dir, 'site_specific', site_name)
# exit

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

puts styles_dir = File.join(root, 'app', 'assets', 'stylesheets')
puts site_styles_dir = File.join(styles_dir, site_name)

if File.directory?(site_styles_dir)
  puts "#{site_styles_dir} exists"
  puts Dir.glob("#{site_styles_dir}/*.sass")
  
  FileUtils.ln Dir.glob("#{site_styles_dir}/*.sass"), styles_dir, force: true
end

puts images_dir = File.join(root, 'app', 'assets', 'images')
puts site_images_dir = File.join(root, 'app', 'assets', 'site_images', site_name, 'images')

if File.directory?(site_images_dir)
  puts "link #{site_name} images into images folder"
  FileUtils.ln_s site_images_dir, images_dir, force: true
end