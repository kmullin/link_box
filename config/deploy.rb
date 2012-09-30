
require "bundler/capistrano"
require "capistrano_colors"

load 'deploy/assets'

set :application, "link_box"
set :repository,  ""

set :deploy_to, "/srv/#{application}"
set :use_sudo, false
set :scm, :git
set :keep_releases, 0

set :ssh_options, {:forward_agent => true}
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "", :app, :web, :db, :primary => true                          # Your HTTP server, Apache/etc

after "deploy:create_symlink", "uploads:symlink"

namespace :uploads do
  task :symlink do
    run "cd #{current_path} && ln -s #{shared_path}/uploads"
  end
end

namespace :deploy do
  task :start do
    run "cd #{current_path} && bundle exec unicorn_rails -c #{shared_path}/unicorn.rb -E production -D"
  end
  task :stop do
    run "test -s #{shared_path}/pids/unicorn.pid && (kill `cat #{shared_path}/pids/unicorn.pid`); true"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "test -s #{shared_path}/pids/unicorn.pid && (kill -USR2 `cat #{shared_path}/pids/unicorn.pid`); true"
  end
end
