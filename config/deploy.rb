# frozen_string_literal: true

lock "3.18.1"

set :application, "decidim"
set :repo_url, "https://github.com/AjuntamentdeReus/decidim.git"
set :linked_files, fetch(:linked_files, []).push(*%w(
  config/database.yml
  .rbenv-vars
))
set :linked_dirs, fetch(:linked_dirs, []).push(*%w(
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
  public/cache
  node_modules
  public/packs
  public/decidim-packs
  public/uploads
  storage
))
set :rbenv_type, :fullstaq
set :passenger_restart_with_touch, true

# TODO
# set :sidekiq_role, :app
# set :sidekiq_service_unit_name, 'sidekiq-decidim'
set :nvm_type, :system
set :nvm_node_path, '/var/lib/nvm/versions/node/'
set :nvm_path, '/var/lib/nvm/'
set :nvm_node, 'v18.17.1' # tls
set :keep_releases, 10

Rake::Task["deploy:compile_assets"].clear

namespace :deploy do
  desc "Pre-compile Deface overrides into templates"
  task :precompile do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env), deface_enabled: true do
          execute :rake, 'deface:precompile'
        end
      end
    end
  end

  desc "Compile assets"
  task :compile_assets => [:set_rails_env] do
    invoke "deploy:decidim_webpacker_install"
    invoke "deploy:install_dependencies"
    invoke "deploy:webpacker_compile"
  end

  desc "Install dependencies"
  task :install_dependencies do
    on roles(:all) do
      execute "cd #{release_path};  nvm use; $HOME/.nvm/versions/node/#{fetch(:nvm_node)}/bin/npm install"
    end
  end

  desc "Webpacker compile"
  task :webpacker_compile do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, "webpacker:compile"
        end
      end
    end
  end

  desc "Decidim webpacker configuration"
  task :decidim_webpacker_install do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "decidim:webpacker:install"
        end
      end
    end
  end
end

namespace :deface do
  desc "Pre-compile Deface overrides into templates"
  task :precompile do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env), deface_enabled: true do
          execute :rake, 'deface:precompile'
        end
      end
    end
  end
end

after 'deploy:updated', 'deface:precompile'
