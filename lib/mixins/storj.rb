module LibUplink
  module Mixins
    require 'yaml'

    def load_yaml_options(path)
      throw(:ENOENT) unless File.exist?(path)

      YAML.load_file(path).to_hash
    end
  end

  module Ext
    module Storj
      module Mixins
        # TODO: any ext mixins?
      end
    end
  end
end
