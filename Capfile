# frozen_string_literal: true

# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/passenger"
require "capistrano/rbenv"
require "capistrano/sidekiq"
# TODO
# install_plugin Capistrano::Sidekiq  # Default sidekiq tasks
# install_plugin Capistrano::Sidekiq::Systemd

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
Dir.glob("lib/capistrano/tasks/*.cap").each { |r| import r }
Dir.glob("lib/capistrano/**/*.rb").each { |r| import r }
