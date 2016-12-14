require 'capistrano-db-tasks'
# Change these
server '46.101.140.24', port: 22, user: 'komi-comix', roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:KomiKomix/komi-comix.git'
set :application,     'komi-comix'
set :user,            'komi-comix'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.access.log"
set :puma_error_log,  "#{shared_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
set :scm,           :git
set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml}
set :linked_dirs,  %w{public/spree public/ckeditor_assets public/assets/ckeditor}

set :rake, "bundle exec rake"

set :keep_releases, 7

set :upload_dirs, %w(public/spree data)
set :shared_children, (fetch(:shared_children) || []) + fetch(:upload_dirs)

set :assets_dir, %w(public/spree/products public/ckeditor_assets)
set :local_assets_dir, 'public/spree'

# if you haven't already specified
set :rails_env, "production"
# if you want to remove the local dump file after loading
set :db_local_clean, true
# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true
# if you want to exclude table from dump
set :db_ignore_tables, []
# if you want to exclude table data (but not table schema) from dump
set :db_ignore_data_tables, []
# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
#set :assets_dir, %w(public/assets public/att)
#set :local_assets_dir, %w(public/assets public/att)
# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :locals_rails_env, "production"

# if you are highly paranoid and want to prevent any push operation to the server
set :disallow_pushing, false

# if you prefer bzip2/unbzip2 instead of gzip
set :compressor, :bzip2

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  #after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

