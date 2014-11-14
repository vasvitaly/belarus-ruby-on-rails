desc 'Deployment config for production server'
task :bjug do
  server '91.149.128.234', :web, :app, :db, primary: true
  set :application, "belarusjug"
  set :bundle_dir, "/home/deploy/.rvm/gems/ruby-1.9.3-p392"
  set :user, "beljug"
  set :rvm_ruby_string, "ruby-1.9.3-p392@bror"
  set :repository, "git@github.com:Altoros/belarus-ruby-on-rails.git"
  set :deploy_to, "/home/beljug/belarusjug"
  set :branch, 'master'
  set :scm, :git
  set :ssh_options, { forward_agent: true }
  set :rails_env, :production
  set :deploy_via, :remote_cache
  set :git_shallow_clone, 1
  
  symlinks = {
      "#{shared_path}/public/ckeditor_assets" => "#{release_path}/public/ckeditor_assets",
      "#{shared_path}/public/images" => "#{release_path}/public/images",
      "#{shared_path}/public/files" => "#{release_path}/public/files",
      "#{shared_path}/public/pub" => "#{release_path}/public/pub",
      "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
      "#{shared_path}/config/social_config.yml" => "#{release_path}/config/social_config.yml"
  }
  # before 'deploy', 'deploy:check_revision'


end
