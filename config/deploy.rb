gem 'capistrano-ext'
require 'rvm/capistrano'
require 'capistrano/ext/multistage'

set :application, "eligant_production"

set :scm, :git
set :repository, "git@github.com:JadeIK/Eligant.git"

set :stages, %w(production development)
set :default_stage, "production"

set :use_sudo, true
set :keep_releases, 5
set :no_reboot, true

set :app_server, :unicorn
set (:unicorn_conf) {"#{current_path}/config/unicorn.rb"}
set (:unicorn_pid) {"#{deploy_to}/tmp/pids/unicorn.pid"}

namespace :deploy do
  task :start do
    run "cd #{current_path} && unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -9 `cat #{unicorn_pid}`; fi"
  end
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -9 `cat #{unicorn_pid}`; fi"
    run "cd #{current_path} && unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  #task :precompile do
  # run "cd #{current_path} && bundle exec rake assets:precompile"
  #end
end

namespace :bundle do
  task :install do
    run "cd #{latest_release} && bundle install"
  end
end

before 'deploy:restart', 'deploy:migrate'
after "deploy:update", "deploy:cleanup"
after "deploy:update_code", "bundle:install"