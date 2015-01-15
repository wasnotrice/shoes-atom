require 'rake/clean'
require_relative 'tasks/rspec'
require_relative 'tasks/find_tagged_specs'

BUILD_DIR = 'build'

OPAL_JS = File.join BUILD_DIR, 'opal.js'
BACKENDS = ['atom', 'browser']
SHOES_JS = BACKENDS.map {|backend| File.join BUILD_DIR, "shoes-#{backend}.js" }
EXAMPLE_APPS = FileList['examples/*']

SHOES_SOURCES = FileList['lib/**/*']

CLOBBER.include FileList[BUILD_DIR]

directory BUILD_DIR

BACKENDS.zip(SHOES_JS).each do |backend, shoes_js|
  file shoes_js => [BUILD_DIR, *SHOES_SOURCES] do
    Opal::Processor.dynamic_require_severity = :warning

    env = Sprockets::Environment.new
    env.append_path 'lib'
    Opal.use_gem 'shoes-core'
    Opal.paths.each { |path| env.append_path path }

    shoes = env["bootstrap/#{backend}"]
    shoes.write_to shoes_js
  end
end

file OPAL_JS => [BUILD_DIR] do
  env = Sprockets::Environment.new
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

    to_copy = FileList.new("skeleton/**/*") do |files|
      files.exclude("skeleton/app.rb")
      files.exclude("skeleton/main.js") if backend == 'browser'
    end

    to_copy.each do |source_file|
      target_file = source_file.pathmap("%{skeleton,#{dist}}p")

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

task 'build:all' => ['build:shoes', 'build:examples']
task :default => ['build:all']
task 'spec:browser' => 'build:shoes'
