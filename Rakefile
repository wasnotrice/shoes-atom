require 'rake/clean'
require_relative 'tasks/rspec'
require_relative 'tasks/find_tagged_specs'
require_relative 'tasks/sample'

BUILD_DIR = 'build'

OPAL_JS = File.join BUILD_DIR, 'opal.js'
BACKENDS = ['atom', 'browser']
EXAMPLE_APPS = FileList['examples/*.rb']
SAMPLE_APPS = samples_from_file("README")

SHOES_SOURCES = FileList['lib/**/*']

CLOBBER.include FileList[BUILD_DIR]

directory BUILD_DIR

BACKENDS.each do |backend|
  shoes_js = File.join(BUILD_DIR, "shoes-#{backend}.js")
  task 'build:shoes' => shoes_js

  file shoes_js => [BUILD_DIR, *SHOES_SOURCES] do
    Opal.append_path 'lib'
    Opal.use_gem 'shoes-core'

    options = {
      compiler_options: {
        dynamic_require_severity: :warning,
        arity_check_enabled: true,
      },
      stubs: [
        'tmpdir',
        'shoes/download',
        'shoes/font',
        'shoes/logger',
      ],
    }
    builder = Opal::Builder.new options
    builder.build("bootstrap/#{backend}")

    File.open(shoes_js, 'w') do |out|
      out.write builder.to_s
    end
  end
end

file OPAL_JS => [BUILD_DIR] do
  env = Sprockets::Environment.new
  File.open(OPAL_JS, 'w+') do |out|
    out << env["opal"].to_s
  end
end

def create_build_tasks_for_app(src, backend, options = {})
  name = src.pathmap("%n")
  src_dir = src.pathmap("%d")
  dist = File.join(BUILD_DIR, name, backend)
  script = File.join(dist, "app.js")
  shoes = File.join(dist, "shoes.js")
  shoes_js = File.join(BUILD_DIR, "shoes-#{backend}.js")
  task_name = "build:#{src_dir}:#{name}"

  directory dist

  to_copy = FileList.new("skeleton/**/*") do |files|
    files.exclude("skeleton/app.rb")
    files.exclude("skeleton/main.js") if backend == 'browser'
  end

  to_copy.each do |source_file|
    target_file = source_file.pathmap("%{skeleton,#{dist}}p")

    file target_file => [dist, source_file] do |t|
      cp source_file, target_file
    end

    task task_name => target_file
  end

  file script => [dist, src] do |t|
    File.open(t.name, 'w+') do |out|
      out << Opal.compile(File.read t.prerequisites[1])
    end
  end

  file shoes => shoes_js do |t|
    cp shoes_js, t.name
  end

  desc "Build the '#{name}' app"
  task task_name => [dist, script, shoes]

  options.fetch(:dependency_of, []).each do |task_depending_on_this|
    task task_depending_on_this => task_name
  end
end

EXAMPLE_APPS.concat(SAMPLE_APPS).each do |src|
  BACKENDS.each do |backend|
    create_build_tasks_for_app src, backend, dependency_of: ['build:examples', 'build:index']
  end
end

namespace :build do
  desc "Build shoes (with bundled opal)"
  task :shoes

  desc "Build standalone opal library"
  task :opal => OPAL_JS

  desc "Build examples"
  task :examples => :index

  task :index do
    contents = "<html><head><title>Examples</title></head><body><h1>Examples</h1><ul>"
    Pathname.new(BUILD_DIR).children.each do |child|
      if child.directory? && child.children.any? { |path| path.directory? && path.basename.to_s == 'browser' }
        contents << %Q{<li><a href="./#{child.basename}/browser/index.html">#{child.basename}<a></li>}
      end
    end
    contents << "</ul></body></html>"
    File.open(File.join(BUILD_DIR, "index.html"), 'w') do |f|
      f.write contents
    end
  end
end

task 'build:all' => ['build:shoes', 'build:examples']
task :default => ['build:all']
task 'spec:browser' => 'build:shoes'
