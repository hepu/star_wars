source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "annotate", "~> 3.2"
gem "devise", "~> 4.9"
gem "devise-jwt", "~> 0.10.0"
gem "fast_jsonapi", "~> 1.5"
gem "foreman", "~> 0.87.2", require: false
gem "kaminari", "~> 1.2"
gem "oj", "~> 3.14"
gem "puma", "~> 5.0"
gem "rack-cors", "~> 2.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sqlite3", "~> 1.4"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.2"
  gem "ffaker", "~> 2.21"
  gem "rspec-rails", "~> 6.0"
end