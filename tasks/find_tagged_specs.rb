def find_specs_matching(regexp)
  ack = `which ack`.chomp
  grep = `which grep`.chomp

  if ack.length > 0
    sh "#{ack} '#{regexp}' spec"
  elsif grep.length > 0
    sh "#{grep} --recursive --extended-regexp '#{regexp}' spec"
  else
    abort "Can't find ack or grep"
  end
end

desc 'Find specs marked :no_browser'
task 'spec:tag:no_browser' do
  find_specs_matching '(it|describe|context)\s.*(:no_browser)'
end


