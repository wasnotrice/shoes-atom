require 'opal'

directory 'ruby-app'

desc "Build ruby-app"
task :build => ['ruby-app'] do
  env = Opal::Environment.new
  env.append_path 'lib'
  env.append_path '../shoes4/lib'

  puts 'after appending shoes path'

  File.open('ruby-app/app.js', 'w+') do |out|
    puts 'before appending to out'
    out << env["bootstrap"].to_s
    puts 'after appending to out'
  end
end
