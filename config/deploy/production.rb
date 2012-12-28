# load "deploy/assets"
set :domain, "jade@93.189.40.170"
set :deploy_to, "/home/jade/eligant_production"
set :rails_env, "development"
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, :primary => true