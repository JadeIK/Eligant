# load "deploy/assets"
set :domain, "jade@jade-cms.com.ua"
set :deploy_to, "/home/jade/system"
set :rails_env, "development"
set :branch, "master"

role :web, domain
role :app, domain
role :db,  domain, :primary => true