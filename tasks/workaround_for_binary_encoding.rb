# CRuby and JRuby (at least) allow for both Encoding.find('BINARY') and
# Encoding.find('binary')
class Encoding
  def self.find(name)
    upcased_name = name.upcase
    return name if self === upcased_name

    constants.each {|const|
      encoding = const_get(const)

      if encoding.name == upcased_name || encoding.names.include?(upcased_name)
        return encoding
      end
    }

    raise ArgumentError, "unknown encoding name - #{name}"
  end
end


