# CLAUDE.md - Laters Ruby Gem

## Build/Test Commands
- Run all tests: `bundle exec rake spec`
- Run single test: `bundle exec rspec spec/path_to_spec.rb:line_number`
- Run RuboCop lint: `bundle exec rubocop`
- Install dependencies: `bundle install`
- Test with specific Rails version: `RAILS_VERSION=7.0 bundle install && bundle exec rake`

## Code Style Guidelines
- Follow standard Ruby style conventions
- Use RuboCop 1.25+ for linting
- RSpec tests use expect syntax (not should syntax)
- Use 2 space indentation
- Private methods are grouped with `private` keyword
- Callbacks are defined after regular methods
- Class methods are defined before instance methods
- ActiveRecord models follow Rails naming conventions
- Error handling uses custom `Laters::Error` class
- Use keyword arguments in method signatures for Rails 7+ compatibility
- Documentation in README for public API features

## Project Structure
The gem follows standard Rails gem structure with:
- `lib/laters.rb` as main entry point
- ActiveRecord models include `Laters::Concern`
- Test suite uses RSpec with Combustion for Rails engine testing
- Queue configuration via `run_in_queue` class method
- Callbacks: `before_laters`, `after_laters`, `around_laters`
- Compatible with Rails 4.2 through 8