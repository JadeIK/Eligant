# load "deploy/assets"
set :domain, "jade@93.187.40.170"
set :deploy_to, "/home/jade/"
set :rails_env, "development"
set :branch, "master"

role :web, domain
role :app, domain
role :db,  domain, :primary => true