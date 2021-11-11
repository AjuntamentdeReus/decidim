# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/decidim/decidim.git", branch: "release/0.20-stable" }

gem "decidim", DECIDIM_VERSION
gem "decidim-removable_authorizations", path: "."
gem "decidim-processes_admin_stats", path: "."

gem "bootsnap", require: false
gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"
gem "faker", "~> 1.8.4"
gem "rollbar"
gem "savon"
gem "progressbar"
gem "deface"
gem "letter_opener_web", "~> 1.3.0"
gem "sidekiq", "~> 5.2.1"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
