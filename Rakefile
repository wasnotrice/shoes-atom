require 'opal'
require 'rake/clean'

RUBY_APP_DIR = 'ruby-app'

OPAL_JS = "#{RUBY_APP_DIR}/opal.js"
SHOES_JS = File.join RUBY_APP_DIR, 'shoes.js'
APP_JS = File.join RUBY_APP_DIR, 'app.js'

SHOES_SOURCES = FileList['lib/**/*']

CLEAN.include FileList[OPAL_JS, SHOES_JS, APP_JS]

directory RUBY_APP_DIR

file SHOES_JS => [RUBY_APP_DIR, *SHOES_SOURCES] do
  Opal::Processor.dynamic_require_severity = :warning

  env = Opal::Environment.new
  env.append_path 'lib'
  env.append_path '../shoes4/lib'

  shoes = env['bootstrap']
  shoes.write_to SHOES_JS
end

file OPAL_JS => [RUBY_APP_DIR] do
  env = Opal::Environment.new
  File.open(OPAL_JS, 'w+') do |out|
    out << env["opal"].to_s
  end
end

file APP_JS => [RUBY_APP_DIR, 'lib/app.rb'] do
  File.open(APP_JS, 'w+') do |out|
    out << Opal.compile(File.read('lib/app.rb'))
  end
end

namespace :build do
  desc "Build shoes (with bundled opal)"
  task :shoes => SHOES_JS

  desc "Build standalone opal library"
  task :opal => OPAL_JS

  desc "Build app"
  task :app => APP_JS
end

task :build => ['build:shoes', 'build:app']
task :default => ['build']
