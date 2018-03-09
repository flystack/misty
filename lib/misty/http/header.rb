module Misty
  module HTTP
    class Header
      def self.valid?(param)
        raise TypeError unless param.class == Hash
        param.each do |key, val|
          raise ArgumentError unless key.class == String
          raise ArgumentError unless val.class == String
        end
        true
      end

      def initialize(param = {})
        @headers = param if self.class.valid?(param)
      end

      def add(param = {})
        @headers.merge!(param) if self.class.valid?(param)
      end

      def get
        @headers
      end
    end
  end
end
