desc 'Deployment config for vbox server'
task :vbox_paaspro do
  server 'vbox', :web, :app, :db, primary: true
  set :bundle_dir, "/home/vitali/.rvm/gems/ruby-1.9.3-p392"
  set :user, 'vitali'
  set :rvm_ruby_string, "ruby-1.9.3-p392@bror"
  set :repository,  'git@github.com:/vasvitaly/belarus-ruby-on-rails.git'
  set :deploy_to, "/home/vitali/paaspro"
  set :branch, 'master'
  set :scm, :git
  set :ssh_options, { forward_agent: true }
  set :deploy_via, :remote_cache
  set :git_shallow_clone, 1
  set :git_enable_submodules, 1
  set :rails_env, :production

  # before 'deploy', 'deploy:check_revision'
  symlinks = {
    "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
    "#{shared_path}/config/social_config.yml" => "#{release_path}/config/social_config.yml"
  }


end
