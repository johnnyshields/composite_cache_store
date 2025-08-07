# frozen_string_literal: true

require "bundler"
require "pry-byebug"

require "active_support/all"
activesupport_version = ActiveSupport.version.to_s

# Clone the repo version of Rails to use its test helpers
TMP_CLONE_DIR = File.join(Dir.tmpdir, "rails_#{activesupport_version}")
unless Dir.exist?(TMP_CLONE_DIR)
  puts "Cloning Rails repo to #{TMP_CLONE_DIR}..."
  system("git clone --depth=1 --branch v#{activesupport_version} https://github.com/rails/rails.git #{TMP_CLONE_DIR}")
end
require "#{TMP_CLONE_DIR}/activesupport/test/testing/method_call_assertions_test"
require "#{TMP_CLONE_DIR}/activesupport/test/cache/behaviors"

# cache test behavior overrides
require_relative "behaviors/composite_cache_store_behavior"
require_relative "behaviors/composite_cache_increment_decrement_behavior"
require_relative "behaviors/composite_cache_store_coder_behavior"

require "minitest/reporters"
Minitest::Reporters.use!

require_relative "../lib/composite_cache_store"
