# frozen_string_literal: true

source "https://rubygems.org"

DECIDIM_VERSION = "0.14.1"

ruby RUBY_VERSION

gem "decidim", DECIDIM_VERSION

gem "bootsnap", require: false
gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"
gem "faker", "~> 1.8.4"
gem "rollbar"
gem "savon"
gem "progressbar"
gem "deface"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3.0"
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
