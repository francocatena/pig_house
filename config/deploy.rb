require 'bundler/capistrano'

set :application, 'mawidabp'
set :repository,  'https://github.com/francocatena/pig_house.git'
set :deploy_to, '/var/rails/pig_house'
set :user, 'deployer'
set :group_writable, false
set :shared_children, %w(system log pids public config)
set :use_sudo, false

set :scm, :git
set :branch, 'master'

set :bundle_without, [:test]

role :web, 'localhost' # Your HTTP server, Apache/etc
role :app, 'localhost' # This may be the same as your `Web` server
role :db,  'localhost', :primary => true # This is where Rails migrations will run

after 'deploy:symlink', 'deploy:create_shared_symlinks'

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc 'Creates the symlinks for the shared folders'
  task :create_shared_symlinks do
    shared_paths = []

    shared_paths.each do |path|
      shared_files_path = File.join(shared_path, *path)
      release_files_path = File.join(release_path, *path)

      run "ln -s #{shared_files_path} #{release_files_path}"
    end
  end
end
