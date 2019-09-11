require 'rubygems'
require 'ffi'
require 'date'

module LibUplink

  class Error < StandardError
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end

  # NB: not currently used but useful for debugging
  require 'struct'
  require 'ext/types'
  require 'ext/ext'

  require 'mixins/storj'

  extend ::LibUplink::Mixins
  extend ::LibUplink::Ext::Storj::Mixins

  require 'errable'
  require 'uplink'
  require 'apikey'
  require 'project'
  require 'bucket_config'
  require 'bucket'
end
