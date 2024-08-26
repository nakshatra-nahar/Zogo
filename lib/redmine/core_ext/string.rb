# frozen_string_literal: true

require File.dirname(__FILE__) + '/string/conversions'
require File.dirname(__FILE__) + '/string/inflections'

# @private
class String
  include ZOGO::CoreExt::String::Conversions
  include ZOGO::CoreExt::String::Inflections
end
