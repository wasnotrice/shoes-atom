require 'opal'
require 'rake/clean'

DIST_DIR = 'dist'

OPAL_JS = File.join DIST_DIR, 'opal.js'
SHOES_JS = File.join DIST_DIR, 'shoes.js'
EXAMPLE_APPS = FileList['examples/*']

SHOES_SOURCES = FileList['lib/**/*']

CLOBBER.include FileList[DIST_DIR]

directory DIST_DIR

file SHOES_JS => [DIST_DIR, *SHOES_SOURCES] do
  Opal::Processor.dynamic_require_severity = :warning

  env = Opal::Environment.new
  env.append_path 'lib'
  env.use_gem 'shoes'

  shoes = env['bootstrap']
  shoes.write_to SHOES_JS
end

file OPAL_JS => [DIST_DIR] do
  env = Opal::Environment.new
  File.open(OPAL_JS, 'w+') do |out|
    out << env["opal"].to_s
  end
end

EXAMPLE_APPS.each do |example|
  src = example.pathmap("%p/src")
  dist = example.pathmap("%p/dist")
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
    target_file = source_file.pathmap("%{src,dist}p")

    file target_file => [dist, source_file] do |t|
      cp source_file, target_file
    end

    task example_task => target_file
  end

  file example_app => [dist, example_app.pathmap("%{dist,src}X.rb")] do |t|
    File.open(t.name, 'w+') do |out|
      out << Opal.compile(File.read t.prerequisites[1])
    end
  end

  file example_shoes => SHOES_JS do |t|
    cp SHOES_JS, t.name
  end

  desc "Build the '#{example_name}' example app"
  task example_task => [dist, example_app, example_shoes]

  task 'build:examples' => example_task
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
