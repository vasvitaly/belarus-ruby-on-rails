desc 'Deployment config for production server'
task :brug do
  server '82.196.4.54', :web, :app, :db, primary: true
  set :application, "belarus-on-rails"
  set :bundle_dir, "/home/deploy/.rvm/gems/ruby-1.9.3-p392"
  set :user, "deploy"
  set :rvm_ruby_string, "ruby-1.9.3-p392@bror"
  set :repository, "git@github.com:Altoros/belarus-ruby-on-rails.git"
  set :deploy_to, "/home/deploy/belarus-on-rails"
  set :branch, 'master'
  set :scm, :git
  set :ssh_options, { forward_agent: true }
  set :rails_env, :production
  set :deploy_via, :remote_cache
  set :git_shallow_clone, 1
  

  symlinks = {
    # "#{shared_path}/ckeditor_assets" => "#{release_path}/public/ckeditor_assets",
    "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
    "#{shared_path}/config/social_config.yml" => "#{release_path}/config/social_config.yml"
  }

  # before 'deploy', 'deploy:check_revision'


end
