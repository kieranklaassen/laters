source "https://rubygems.org"

# Specify your gem's dependencies in laters.gemspec
gemspec

rails_version = ENV['RAILS_VERSION'] || '7.0'

case rails_version
when '6.1'
  gem 'rails', '~> 6.1.0'
when '7.0'
  gem 'rails', '~> 7.0.0'
when '7.1'
  gem 'rails', '~> 7.1.0'
when '8.0'
  gem 'rails', '~> 8.0.0'
else
  gem 'rails', '~> 7.0.0'
end

gem "sqlite3"
gem "rake", "~> 13.0"
gem "rspec", "~> 3.12"
gem "rspec-rails"
gem 'combustion', '~> 1.3'
gem "rubocop", "~> 1.25.0"
