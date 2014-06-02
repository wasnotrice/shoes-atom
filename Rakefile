require 'opal'
require 'rake/clean'
require 'opal/rspec/rake_task'

Opal::RSpec::RakeTask.new(:spec)

DIST_DIR = 'dist'

OPAL_JS = File.join DIST_DIR, 'opal.js'
BACKENDS = ['atom', 'browser']
SHOES_JS = BACKENDS.map {|backend| File.join DIST_DIR, "shoes-#{backend}.js" }
EXAMPLE_APPS = FileList['examples/*']

SHOES_SOURCES = FileList['lib/**/*']

CLOBBER.include FileList[DIST_DIR]

directory DIST_DIR

BACKENDS.zip(SHOES_JS).each do |backend, shoes_js|
  file shoes_js => [DIST_DIR, *SHOES_SOURCES] do
    Opal::Processor.dynamic_require_severity = :warning

    env = Opal::Environment.new
    env.append_path 'lib'
    env.use_gem 'shoes-dsl'

    shoes = env["bootstrap/#{backend}"]
    shoes.write_to shoes_js
  end
end

file OPAL_JS => [DIST_DIR] do
  env = Opal::Environment.new
  File.open(OPAL_JS, 'w+') do |out|
    out << env["opal"].to_s
  end
end

EXAMPLE_APPS.each do |example|
  src = example.pathmap("%p/src")
  BACKENDS.zip(SHOES_JS).each do |backend, shoes_js|
    dist = example.pathmap("%p/#{backend}")
    example_app = dist.pathmap("%p/app.js")
    example_shoes = dist.pathmap("%p/shoes.js")
    example_name = example.pathmap("%f")
    example_task = "build:examples:#{example_name}"

    directory dist
    CLOBBER.include dist

    to_copy = FileList.new("#{src}/**/*") do |files|
      files.exclude("#{src}/app.rb")
    end

    to_copy.each do |source_file|
      target_file = source_file.pathmap("%{src,#{backend}}p")

      file target_file => [dist, source_file] do |t|
        cp source_file, target_file
      end

      task example_task => target_file
    end

    file example_app => [dist, example_app.pathmap("%{#{backend},src}X.rb")] do |t|
      File.open(t.name, 'w+') do |out|
        out << Opal.compile(File.read t.prerequisites[1])
      end
    end

    file example_shoes => shoes_js do |t|
      cp shoes_js, t.name
    end

    desc "Build the '#{example_name}' example app"
    task example_task => [dist, example_app, example_shoes]

    task 'build:examples' => example_task
  end
end

namespace :build do
  desc "Build shoes (with bundled opal)"
  task :shoes => SHOES_JS

  desc "Build standalone opal library"
  task :opal => OPAL_JS

  desc "Build examples"
  task :examples
end

task :build => ['build:shoes', 'build:examples']
task :default => ['build']
