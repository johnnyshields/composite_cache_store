# frozen_string_literal: true

require "bundler"
require "pry-byebug"

def use_rails_repo(version = nil)
  dir = File.join(Dir.tmpdir, "rails_#{version || 'main'}")
  unless Dir.exist?(dir)
    puts "Cloning Rails repo to #{dir}..."
    system("git clone --depth=1#{" --branch v#{version}" if version} https://github.com/rails/rails.git #{dir}")
  end
  require "#{dir}/activesupport/test/testing/method_call_assertions_test"
  require "#{dir}/activesupport/test/cache/behaviors"
end

require "active_support/all"
begin
  use_rails_repo(ActiveSupport.version.to_s)
rescue LoadError
  use_rails_repo
end

# cache test behavior overrides
require_relative "behaviors/composite_cache_store_behavior"
require_relative "behaviors/composite_cache_increment_decrement_behavior"
require_relative "behaviors/composite_cache_store_coder_behavior"

require "minitest/reporters"
Minitest::Reporters.use!

require_relative "../lib/composite_cache_store"
