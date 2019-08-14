require 'rubygems'
require 'ffi'
require 'date'

module LibUplink
  # NB: not currently used but useful for debugging
  require 'struct'
  require 'ext/types'
  require 'ext/ext'

  require 'mixins/storj'

  extend ::LibUplink::Mixins
  extend ::LibUplink::Ext::Storj::Mixins

  require 'uplink'
end
