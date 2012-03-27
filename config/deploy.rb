require 'bundler/capistrano'
set :application, "belarus-on-rails"
set :deploy_to, "/home/deploy/belarus-on-rails"
set :rails_env, 'production'
set :branch, 'master'
server '50.57.221.109', :web, :app, :db, :primary => true
set :normalize_asset_timestamps, false

set :use_sudo, false
set :user, "deploy"
set :scm, :git
set :repository, "git@github.com:Altoros/belarus-ruby-on-rails.git"
set :deploy_via, :checkout

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:update_code", :symlink_config_files

task :symlink_config_files do
  symlinks = {
    "#{shared_path}/ckeditor_assets" => "#{release_path}/public/ckeditor_assets",
    "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
    "#{shared_path}/config/social_config.yml" => "#{release_path}/config/social_config.yml"
  }
  run symlinks.map{|from, to| "ln -nfs #{from} #{to}"}.join(" && ")
  run "chmod -R g+rw #{release_path}/public"
end
