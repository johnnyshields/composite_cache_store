# frozen_string_literal: true

source "https://rubygems.org"

if ENV["GITHUB_ACTIONS"] || ENV["COMPOSITE_CACHE_STORE_ENV"] == "test"
  case (rails_version = ENV["RAILS_VERSION"])
  when "master", "main", "edge"
    git "https://github.com/rails/rails.git" do
      gem "activesupport", require: "active_support"
    end
  when /\A\d+\z/
    gem "activesupport", "~> #{rails_version}.0.0", require: "active_support"
  when /\A\d+\.\d+\z/
    gem "activesupport", "~> #{rails_version}.0", require: "active_support"
  else
    gem "activesupport", rails_version, require: "active_support"
  end
end

gemspec
