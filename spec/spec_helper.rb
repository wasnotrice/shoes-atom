#SHOESSPEC_ROOT = File.expand_path('..', __FILE__)
#$LOAD_PATH << File.join('../lib', SHOESSPEC_ROOT)

# require 'code_coverage'
# require 'rspec'
# require 'pry'
# require 'shoes'
# require 'async_helper'
# require 'shoes/helpers/fake_element'

# shared_examples = File.expand_path('../shoes/shared_examples/**/*.rb', __FILE__)
# Dir[shared_examples].each { |f| require f }

RSpec.configure do |config|
  config.filter_run_excluding :opal => false
end

require 'rspec/its'
ENV['SHOES_BACKEND'] = 'mock'
require 'shoes/mock'

# require 'shoes/shared_examples/button'
# require 'shoes/shared_examples/changeable'
# require 'shoes/shared_examples/clickable'
# require 'shoes/shared_examples/common_methods'
# require 'shoes/shared_examples/dimensions'
# require 'shoes/shared_examples/dsl'
# require 'shoes/shared_examples/dsl/animate'
# require 'shoes/shared_examples/dsl/arc'
# require 'shoes/shared_examples/dsl/background'
# require 'shoes/shared_examples/dsl/border'
# require 'shoes/shared_examples/dsl/cap'
# require 'shoes/shared_examples/dsl/check'
# require 'shoes/shared_examples/dsl/edit_box'
# require 'shoes/shared_examples/dsl/edit_line'
# require 'shoes/shared_examples/dsl/editable_element'
# require 'shoes/shared_examples/dsl/fill'
# require 'shoes/shared_examples/dsl/flow'
# require 'shoes/shared_examples/dsl/gradient'
# require 'shoes/shared_examples/dsl/image'
# require 'shoes/shared_examples/dsl/line'
# require 'shoes/shared_examples/dsl/nofill'
# require 'shoes/shared_examples/dsl/nostroke'
# require 'shoes/shared_examples/dsl/oval'
# require 'shoes/shared_examples/dsl/pattern'
# require 'shoes/shared_examples/dsl/progress'
# require 'shoes/shared_examples/dsl/rect'
# require 'shoes/shared_examples/dsl/rgb'
# require 'shoes/shared_examples/dsl/shape'
# require 'shoes/shared_examples/dsl/star'
# require 'shoes/shared_examples/dsl/stroke'
# require 'shoes/shared_examples/dsl/strokewidth'
# require 'shoes/shared_examples/dsl/style'
# require 'shoes/shared_examples/dsl/text_elements'
# require 'shoes/shared_examples/dsl_app_context'
# require 'shoes/shared_examples/hover_leave'
# require 'shoes/shared_examples/parent'
# require 'shoes/shared_examples/shared_element_method'
# require 'shoes/shared_examples/slot'
# require 'shoes/shared_examples/state'
# require 'shoes/shared_examples/style'
# 
# require 'shoes/helpers/inspect_helpers'
