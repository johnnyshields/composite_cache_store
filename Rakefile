# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"
require "paint"

# versions of rails to test against
rails_versions = %w[
  6.0.6.1
  6.1.7.10
  7.0.8.7
  7.1.5.1
  7.2.2.1
  8.0.2
  edge
]

task default: :test

Minitest::TestTask.create(:minitest) do |t|
  t.test_globs = ["test/**/*_test.rb"]
end

task :test do
  ENV["COMPOSITE_CACHE_STORE_ENV"] = "test"

  if ENV["RAILS_VERSION"]
    Rake::Task["minitest"].invoke
    return
  end

  begin
    rails_versions.each do |rails_version|
      ENV["RAILS_VERSION"] = (rails_version == "edge") ? nil : rails_version
      puts Paint % ["Bundling activesupport %{version} from github ", :blue, :underline, version: [rails_version, "sky blue", :underline]]
      print Paint["required for tests provided by rails... ", "slate gray"]
      `bundle update activesupport`
      puts "done!\n\n"
      Rake::Task["minitest"].invoke
      Rake::Task["minitest"].reenable unless rails_version == rails_versions.last
    end
  ensure
    if ENV["GITHUB_ACTIONS"] != "true"
      ENV["COMPOSITE_CACHE_STORE_ENV"] = nil
      print Paint["Restoring bundle with activesupport from rubygems... ", :blue]
      `bundle update activesupport`
      puts "done!"
    end
  end
end
