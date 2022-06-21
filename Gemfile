# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.26.2"

gem "decidim", DECIDIM_VERSION
gem "decidim-removable_authorizations", path: "."
gem "decidim-processes_admin_stats", path: "."
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "develop"
gem "decidim-decidim_awesome", "~> 0.8"
gem "decidim-question_captcha", git: "https://github.com/PopulateTools/decidim-module-question_captcha.git", branch: "0.26_2_update"
gem "acts_as_textcaptcha", "~> 4.5.1"

gem "bootsnap", require: false
gem "puma", ">= 4.3"
gem "uglifier", ">= 1.3.0"
gem "faker", "~> 2.14"
gem "rollbar"
gem "savon"
gem "progressbar"
gem "deface"
gem "letter_opener_web", "~> 1.4"
gem "sidekiq", "~> 6.4.1"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "listen", "~> 3.1"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console"
end
