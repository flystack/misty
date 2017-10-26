module Misty
  module HTTP
    class Header
      class ArgumentError < RuntimeError; end
      class TypeError     < RuntimeError; end

      def self.valid?(param)
        raise Misty::HTTP::Header::TypeError unless param.class == Hash
        param.each do |key, val|
          raise Misty::HTTP::Header::ArgumentError unless key.class == String
          raise Misty::HTTP::Header::ArgumentError unless val.class == String
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
