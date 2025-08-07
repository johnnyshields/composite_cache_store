# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

# versions of rails to test against
rails_versions = %w[
  6.1
  7.0
  7.1
  7.2
  8.0
  edge
]

task default: :test

Minitest::TestTask.create(:minitest) do |t|
  t.test_globs = ["test/**/*_test.rb"]
end

task :test do
  Rake::Task["minitest"].invoke
end
