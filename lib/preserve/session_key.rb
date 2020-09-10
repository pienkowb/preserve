require 'digest/sha1'

module Preserve
  class SessionKey
    def initialize(controller_class, parameter_key)
      @controller_class = controller_class
      @parameter_key = parameter_key
    end

    def build
      [:preserve, calculate_digest].join('_')
    end

    private

    attr_reader :controller_class
    attr_reader :parameter_key

    def calculate_digest
      Digest::SHA1.hexdigest(input_data)
    end

    def input_data
      [controller_class, parameter_key.class, parameter_key].join('_')
    end
  end
end
