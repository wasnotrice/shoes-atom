# Mostly copied from shoes.rb
puts "Bootstrapping requires"
STDERR.puts "Err bootstrapping requires"

require 'pathname'
# Opal doesn't like
# require 'tmpdir'
# Opal doesn't like
# require 'fileutils'
require 'forwardable'

require 'shoes/common/registration'

require 'shoes/version'
require 'shoes/renamed_delegate'
require 'shoes/dimension'
require 'shoes/dimensions'

require 'shoes/color'

require 'shoes/common/background_element'
require 'shoes/common/changeable'
require 'shoes/common/clickable'
require 'shoes/common/common_methods'
require 'shoes/common/fill'
require 'shoes/common/state'
require 'shoes/common/stroke'
require 'shoes/common/style'
require 'shoes/common/style_normalizer'
require 'shoes/builtin_methods'
require 'shoes/check_button'
# parse error on value "color" (tIDENTIFIER) :shoes/dsl:388
require 'shoes/dsl'
require 'shoes/text'
require 'shoes/span'
require 'shoes/input_box'

# please keep this list tidy and alphabetically sorted
require 'shoes/animation'
require 'shoes/app'
require 'shoes/arc'
require 'shoes/background'
require 'shoes/border'
require 'shoes/button'
require 'shoes/configuration'
require 'shoes/color'
require 'shoes/dialog'
# couldn't find file 'open-uri'
# require 'shoes/download'
require 'shoes/font'
require 'shoes/gradient'
require 'shoes/image'
require 'shoes/image_pattern'
require 'shoes/key_event'
require 'shoes/line'
require 'shoes/link'
require 'shoes/link_hover'
require 'shoes/list_box'
# Cannot handle dynamic require :shoes/logger:65
# require 'shoes/logger'
puts "after shoes/logger"
require 'shoes/manual'
require 'shoes/oval'
require 'shoes/point'
require 'shoes/progress'
require 'shoes/radio'
require 'shoes/rect'
require 'shoes/shape'
require 'shoes/slot_contents'
require 'shoes/slot'
require 'shoes/star'
require 'shoes/sound'
require 'shoes/text_block'
require 'shoes/timer'
require 'shoes/url'
require 'shoes/widget'

# Now that we've required all of the Shoes deps
puts "before shoes require in bootstrap"
require 'shoes'
puts "after shoes require in bootstrap"
require 'app'
