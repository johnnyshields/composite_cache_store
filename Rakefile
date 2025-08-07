# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"
require "paint"

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

task :test_all do
  ENV["CCS_TEST_ALL"] = "test"
  rails_versions.each do |rails_version|
    ENV["RAILS_VERSION"] = rails_version
    puts Paint % ["Bundling activesupport %{version}", :blue, :underline, version: [rails_version, "sky blue", :underline]]
    print Paint["required for tests provided by rails... ", "slate gray"]
    `bundle update activesupport`
    puts "done!\n\n"
    Rake::Task["minitest"].invoke
    Rake::Task["minitest"].reenable unless rails_version == rails_versions.last
  end
ensure
  ENV["CCS_TEST_ALL"] = nil
  print Paint["Restoring bundle with activesupport from rubygems... ", :blue]
  `bundle update activesupport`
  puts "done!"
end
