require 'opal'

Opal::Processor.dynamic_require_severity = :warning
Opal.append_path File.expand_path('../../build', __FILE__)
Opal.append_path File.expand_path('../../lib', __FILE__)
Opal.append_path File.expand_path('../../spec', __FILE__)
Opal.append_path File.expand_path('../../vendor', __FILE__)
Opal.use_gem 'shoes-core'
Opal.use_gem 'rspec-its'
#Opal.use_gem 'webmock'

require 'opal/rspec/rake_task'
Opal::RSpec::RakeTask.new('spec:dsl')
Opal::RSpec::RakeTask.new('spec:browser') do |server|
  server.debug = true
  server.index_path = File.expand_path('../../spec/browser/index.erb', __FILE__)
end
