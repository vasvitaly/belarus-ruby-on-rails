require "rvm/capistrano"

require 'bundler/capistrano'
require "whenever/capistrano"
require "delayed/recipes"
set :use_sudo, false
set :normalize_asset_timestamps, false
set :whenever_command, "bundle exec whenever"

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after "deploy:update_code", :symlink_config_files

task :symlink_config_files do
  symlinks = {
      # "#{shared_path}/ckeditor_assets" => "#{release_path}/public/ckeditor_assets",
      "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
      "#{shared_path}/config/social_config.yml" => "#{release_path}/config/social_config.yml"
  }
  run symlinks.map { |from, to| "ln -nfs #{from} #{to}" }.join(" && ")
  run "chmod -R g+rw #{release_path}/public"
end

namespace :solr do
  task :kill, :except => {:no_release => true} do
    #run "cd #{current_path} && bundle exec rake sunspot:solr:stop RAILS_ENV=#{rails_env}"
    run "pkill java || true"
  end

  task :symlink, :except => {:no_release => true} do
    run "ln -nfs #{shared_path}/solr #{current_path}/solr"
    run "ls -al #{current_path}/solr/pids/"
    run "cd #{current_path} && bundle exec rake sunspot:solr:start RAILS_ENV=#{rails_env}"
    run "cd #{current_path} && yes | bundle exec rake sunspot:reindex[1000] RAILS_ENV=#{rails_env}"
  end
end

before "deploy:update_code", "solr:kill"
after "deploy:restart", "solr:symlink"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

after "deploy:restart", "deploy:cleanup"
