# frozen_string_literal: true

require "bundler"
require "fileutils"

def use_rails_repo(version = nil)
  tmp = File.join(__dir__, '../tmp')
  FileUtils.mkdir_p(tmp)
  dir = File.join(tmp, "rails_#{version || 'main'}")
  unless Dir.exist?(dir)
    puts "Cloning Rails repo to #{dir}..."
    system("git clone --sparse --depth=1 --filter=blob:none https://github.com/rails/rails.git #{dir}")
    Dir.chdir(dir) do
      system('git sparse-checkout init --cone')
      system('git sparse-checkout set activesupport tools')
      system("git checkout#{" v#{version}" if version}")
    end
  end

  paths = ["#{dir}/activesupport/test", "#{dir}/activesupport/lib"]
  begin
    $LOAD_PATH.unshift(*paths)
    require "#{dir}/activesupport/test/testing/method_call_assertions_test"
    require "#{dir}/activesupport/test/cache/behaviors"
  rescue StandardError => e
    $LOAD_PATH -= paths
    raise e
  end
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
