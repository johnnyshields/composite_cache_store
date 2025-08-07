# frozen_string_literal: true

source "https://rubygems.org"

case (rails_version = ENV["RAILS_VERSION"])
when "master", "main", "edge"
  git "https://github.com/rails/rails.git" do
    gem "activesupport", require: "active_support"
  end
when /\A\d+\z/
  gem "activesupport", "~> #{rails_version}.0.0", require: "active_support"
when /\A\d+\.\d+\z/
  gem "activesupport", "~> #{rails_version}.0", require: "active_support"
when /\d/
  gem "activesupport", rails_version, require: "active_support"
end

gemspec
