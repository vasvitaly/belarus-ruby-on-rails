desc 'Deployment config for dev.ethn.io server'
task :dev do
  server 'dev.ethn.io', :web, :app, :db, primary: true
  set :repository,  'git@bitbucket.org:Ethnio/ethnio.git'
  set :branch, 'calendar_v2'
  set :scm, :git
  set :ssh_options, { forward_agent: true }
  set :deploy_via, :remote_cache
  set :git_shallow_clone, 1
  set :git_enable_submodules, 1
  set :rails_env, :dev

  before 'deploy', 'deploy:check_revision'


end
