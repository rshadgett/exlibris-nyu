module Exlibris
  module Nyu
    module Coverage
      class Bib866L
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def sub_library
          @sub_library ||= pair['sub_library'] unless pair.nil?
        end

        def collection
          @collection ||= pair['collection'] unless pair.nil?
        end

        private
        def config_file
          File.expand_path('../../../../../config/bib_866_l.yml', __FILE__)
        end

        def config
          YAML.load_file(config_file)
        end

        def pair
          @pair ||= config[value]
        end
      end
    end
  end
end
