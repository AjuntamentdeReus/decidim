# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim.git", branch: "release/0.28-stable" }.freeze

gem "decidim", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION
gem "decidim-removable_authorizations", path: "."
gem "decidim-processes_admin_stats", git: "https://github.com/PopulateTools/decidim-module-processes_admin_stats.git", branch: "main"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "main"
gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome.git", branch: "users_autoblock"
gem "decidim-extra_user_fields", git: "https://github.com/PopulateTools/decidim-module-extra_user_fields.git", branch: "interests_field"
gem "decidim-trusted_ids", git: "https://github.com/PopulateTools/decidim-module-trusted-ids", branch: "upgrade-0.28"

# gem "decidim-question_captcha", git: "https://github.com/OpenSourcePolitics/decidim-module-question_captcha.git", branch: "release/0.27-stable"
gem "acts_as_textcaptcha", "~> 4.6.0"

gem "bootsnap", require: false
gem "puma", ">= 6.3"
gem "faker", "~> 3.2"
gem "savon"
gem "progressbar"
gem "deface"
gem "letter_opener_web", "~> 1.4"
gem "sidekiq", "~> 5.2.10"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec"
  gem "decidim-dev", DECIDIM_VERSION
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "capistrano-sidekiq"
  gem "capistrano-nvm", require: false
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
end

group :development do
  gem "listen", "~> 3.1"
end
