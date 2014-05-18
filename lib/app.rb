puts "Hello, world!"
puts "Running Shoes #{Shoes::VERSION}"

Shoes.app :width => 12 do
  banner "Hello, world!"
end
