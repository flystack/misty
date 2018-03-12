module Misty
  module Helper
    def self.json_encode?(data)
      return true if data.is_a?(Array) || data.is_a?(Hash)
      if data.is_a?(String)
        begin
          JSON.parse(data)
        rescue JSON::ParserError
          return false
        else
          return true
        end
      end
      return false
    end


    def self.to_json(data)
      if data.is_a? String
        JSON.parse(data)
        return data
      end
      return JSON.dump(data)
    end
  end
end
