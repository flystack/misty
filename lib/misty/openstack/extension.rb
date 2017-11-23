module Misty
  module Openstack
    module Extension
      def api
        @api_fusion ||= begin
          list = super
          api_ext.each do |key, value|
            if list.include?(key)
              target = list[key]
              value.each do |verb, methods|
                if target.has_key?(verb)
                  # Add methods to existing Verb
                  methods.each do |method|
                    raise RuntimeError, "#{key} => #{verb} already includes: #{method}" if target[verb].include?(method)
                    target[verb] << method
                  end
                else
                  # Add Verb
                  target.merge!(verb => methods)
                end
              end
            else
              # Add Resource
              list.merge!(key => value)
            end
          end
          list
        end
        @api_fusion
      end
    end
  end
end
