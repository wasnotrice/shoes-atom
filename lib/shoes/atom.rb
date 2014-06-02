class Shoes
  module Atom
    # The Atom backend just reuses these browser classes
    %w[Banner Flow Keypress TextBlock].each do |klass|
      const_set klass, Shoes::Browser.const_get(klass)
    end
  end
end
