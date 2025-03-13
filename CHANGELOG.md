# 0.3.0 (18-3-2025)

## New Features
- Added scheduled job support via `wait`, `wait_until`, and `priority` options
- Support ActiveJob scheduling options with the same interface as `perform_later`

## Bug Fixes and Improvements
- Fixed compatibility issues with newer Ruby and Rails versions
- Fixed DidYouMean deprecation warnings by upgrading Thor dependency
- Fixed Logger class compatibility with ActiveSupport
- Improved test suite with additional edge cases

# 0.2.0 (15-3-2025)

## Major Enhancements
- Added official support for Rails 5.0 through 8.0
- Added support for Ruby 3.0 through 3.4
- Added comprehensive YARD documentation for all methods and classes

## Improvements
- Enhanced callback support with comprehensive tests (`before_laters`, `after_laters`, `around_laters`)
- Added proper keyword arguments support throughout the codebase
- Fixed compatibility with ActiveJob in Rails 7+
- Updated Thor dependency to fix DidYouMean warnings
- Added test cases for all scheduling and parameter options
- Added time-related testing helpers to improve test reliability

# 0.1.2 (26-8-2020)

- Add build badge to readme
- Remove Zeitwerk

# 0.1.1 (23-8-2020)

- Rename gem to `laters`

# 0.1.0 (23-8-2020)

- Initial version
