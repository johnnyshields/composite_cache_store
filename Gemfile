# frozen_string_literal: true

source "https://rubygems.org"

if ENV["GITHUB_ACTIONS"] || ENV["COMPOSITE_CACHE_STORE_ENV"] == "test"
  git "https://github.com/rails/rails.git", tag: ENV["RAILS_VERSION"]&.gsub(/\Av?/, 'v') do
    gem "activesupport", require: "active_support"
  end

  # Hack to fix Rails 6.x and 7.0
  # https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror
  if ENV["RAILS_VERSION"]&.match?(/\A\D*?(?:6|7\.0)(?:\.|\z)/)
    gem 'concurrent-ruby', '1.3.4'
  end

  # Load gems removed from Ruby kernel
  gem 'base64'
  gem 'mutex_m'
  gem 'drb'
end

gemspec
