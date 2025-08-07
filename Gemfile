# frozen_string_literal: true

source "https://rubygems.org"

case (rails_version = ENV["RAILS_VERSION"])
when "master", "main", "edge"
  git "https://github.com/rails/rails.git" do
    gem "activesupport", require: "active_support"
  end
when /\A\d+(?:\.\d+)?\z/
  gem "activesupport", "~> #{rails_version}.0", require: "active_support"
when /\d/
  gem "activesupport", rails_version, require: "active_support"
end

# Hack to fix Rails 6.x and 7.0
# https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror
if rails_version&.match?(/\A\D*?(?:6|7\.0)(?:\.|\z)/)
  gem 'concurrent-ruby', '1.3.4'
end

gemspec
