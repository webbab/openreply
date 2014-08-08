require "bundler/capistrano"
require "capistrano/ext/multistage"
require "rvm/capistrano"
require "dotenv"
require "dotenv/deployment/capistrano"
Dotenv.load '.env'

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs

set :stages, %w(production staging)
set :default_stage, "staging"

set :application, "openreply"

set :scm, :git
set :repository, ENV['OPENREPLY_DEPLOY_REPOSITORY']
set :local_repository, ENV['OPENREPLY_DEPLOY_REPOSITORY']

set :use_sudo, false
set :deploy_via, :copy
set :copy_exclude, [".git/*", ".gitignore", ".DS_Store"]

set :normalize_asset_timestamps, false

namespace :deploy do
  desc "Tell Puma to do a hot restart."
  task :restart do
    run "/bin/kill `cat /var/run/puma/puma.pid`"
    deploy.start
  end

  desc "Tell Puma to start."
  task :start do
    run "cd #{fetch(:deploy_to)}/current && bundle exec puma --daemon --environment production --port 8000 --pidfile /var/run/puma/puma.pid"
  end

end
