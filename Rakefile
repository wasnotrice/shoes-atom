require 'opal'
require 'rake/clean'

RUBY_APP_DIR = 'ruby-app'

OPAL_JS = "#{RUBY_APP_DIR}/opal.js"
SHOES_JS = File.join RUBY_APP_DIR, 'shoes.js'
APP_JS = File.join RUBY_APP_DIR, 'app.js'

CLEAN.include FileList[OPAL_JS, SHOES_JS, APP_JS]

directory RUBY_APP_DIR

namespace :build do
  desc "Build shoes"
  task :shoes => [RUBY_APP_DIR] do
    Opal::Processor.dynamic_require_severity = :warning

    env = Opal::Environment.new
    env.append_path 'lib'
    env.append_path '../shoes4/lib'

    shoes = env['shoes']
    shoes.write_to SHOES_JS

    # File.open('ruby-app/shoes.js', 'w+') do |out|
    #   out << env["bootstrap"].to_s
    # end
  end

  desc "Build Opal"
  task :opal => [RUBY_APP_DIR] do
    env = Opal::Environment.new
    File.open(OPAL_JS, 'w+') do |out|
      out << env["opal"].to_s
    end
  end

  desc "Build app"
  task :app => [RUBY_APP_DIR] do
    File.open(APP_JS, 'w+') do |out|
      out << Opal.compile(File.read('lib/app.rb'))
    end
  end
end


task :build => ['build:shoes', 'build:app']
