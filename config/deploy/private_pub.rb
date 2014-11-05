set(:private_pub_pid) { "#{current_path}/tmp/pids/private_pub.pid" }

namespace :private_pub do
  desc "Start private_pub server"
  task :start do
    run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec thin -C config/private_pub/thin_#{rails_env}.yml -d -P #{private_pub_pid} start"
  end

  desc "Stop private_pub server"
  task :stop do
    run "cd #{current_path};if [ -f #{private_pub_pid} ] && [ -e /proc/$(cat #{private_pub_pid}) ]; then kill -9 `cat #{private_pub_pid}`; fi"
  end

  desc "Restart private_pub server"
  task :restart do
    stop
    start
  end
end

after 'deploy:start', 'private_pub:start'
after 'deploy:stop',  'private_pub:stop'
after 'deploy:restart', 'private_pub:restart'

# RAILS_ENV=dev bundle exec thin -C config/private_pub/thin_dev.yml -d -P /u/apps/ethnio/current/tmp/pids/private_pub.pid start