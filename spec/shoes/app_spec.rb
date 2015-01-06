require 'shoes/spec_helper'

describe Shoes::App do
  subject { [1, 2, 3] }

  its(:length) { should eq(3) }
end
