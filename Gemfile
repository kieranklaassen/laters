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

# Required for Ruby 3.0+ and Rails 7+ compatibility
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'

gem "sqlite3", "~> 1.4"
gem "rake"
gem "rspec"
gem "rspec-rails"
gem 'combustion'
gem "rubocop"
