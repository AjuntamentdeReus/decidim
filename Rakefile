# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

Rake::Task["shakapacker:check_yarn"].clear
Rake::Task["shakapacker:yarn_install"].clear
Rake::Task["webpacker:check_yarn"].clear
Rake::Task["webpacker:yarn_install"].clear
