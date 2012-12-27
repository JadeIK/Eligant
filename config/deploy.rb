require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano' # Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика. 

set :application, "eligant_production"
set :rails_env, "production"
set :domain, "jade@93.189.40.170" # Это необходимо для деплоя через ssh. Именно ради этого я настоятельно советовал сразу же залить на сервер свой ключ, чтобы не вводить паролей.
set :deploy_to, "/home/jade/#{application}"
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :rvm_ruby_string, '1.9.3' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  "git@github.com:JadeIK/Eligant.git" # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить их в deployment keys в настройках репозитария.
set :branch, "master" # Ветка из которой будем тянуть код для деплоя.
#set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

role :web, domain
role :app, domain
role :db,  domain, :primary => true

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'
#
#after 'deploy:update_code', :roles => :app do
#  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них в нужные места приложения.
#  run "rm -f #{current_release}/config/database.yml"
#  #run "chmod +x -f #{current_release}/config/database.yml"
#  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
#end


# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
# В случае с Rails 3 приложениями стоит заменять bundle exec unicorn_rails на bundle exec unicorn
namespace :deploy do
  desc "Custom AceMoney deployment: stop."
  task :stop, :roles => :app do

    invoke_command "cd #{current_path};./script/ferret_server -e production stop"
    invoke_command "service thin stop"
  end

  desc "Custom AceMoney deployment: start."
  task :start, :roles => :app do

    invoke_command "cd #{current_path};./script/ferret_server -e production start"
    invoke_command "service thin start"
  end

  # Need to define this restart ALSO as 'cap deploy' uses it
  # (Gautam) I dont know how to call tasks within tasks.
  desc "Custom AceMoney deployment: restart."
  task :restart, :roles => :app do

    invoke_command "cd #{current_path};./script/ferret_server -e production stop"
    invoke_command "service thin stop"
    invoke_command "cd #{current_path};./script/ferret_server -e production start"
    invoke_command "service thin start"
  end
end
