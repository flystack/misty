module Misty
  module HTTP
    module MethodBuilder
      def method_missing(method_name, *args)
        if method = get_method(method_name)
          method_call(method, *args)
        else
          raise NoMethodError, "#{self.class}: #{method_name}"
        end
      end

      private

      def method_call(method, *args)
        base, path = prefixed_path(method[:path])
        size_path_parameters = count_path_params(path)
        path_params = args[0, size_path_parameters]
        args_left = args - path_params
        path = inject_elements(path, path_params)
        final_path = base_filter(base, path)

        case method[:request]
        when :COPY
          http_copy(final_path, headers)
        when :DELETE
          http_delete(final_path, headers)
        when :GET
          final_path << query_param(args_left[0]) if args_left && args_left.size == 1
          http_get(final_path, headers)
        when :HEAD
          http_head(final_path, headers, data)
        when :POST
          data = args_left[0] if args_left && args_left.size == 1
          http_post(final_path, headers, data)
        when :PUT
          data = args_left[0] if args_left && args_left.size == 1
          http_put(final_path, headers, data)
        when :PATCH
          data = args_left[0] if args_left && args_left.size == 1
          http_patch(final_path, headers, data)
        else
          raise SyntaxError, "Invalid HTTP request: #{method[:request]}"
        end
      end

      def base_filter(base, path)
        return (@base_path + path) if base
        return path
      end

      def count_path_params(str)
        subpath = /(.*)(\{.*\})(.*)/.match(str)
        return 0 unless subpath
        return count_path_params(subpath[1]) + 1
      end

      def get_method(name)
        self.class.api.each do |path, requests|
          requests.each do |request, methods_list|
            if methods_list.include?(name)
              return {:path => path, :request => request, :name => name}
            end
          end
        end
        nil
      end

      def inject_elements(str, args)
        subpath = /(.*)(\{.*\})(.*)/.match(str)
        return str unless subpath
        arg = args.pop
        raise ArgumentError, 'Not enough arguments' unless arg
        return inject_elements(subpath[1], args) + arg + subpath[3]
      end

      def prefixed_path(path)
        unless self.class.prefix_path_to_ignore.empty?
          if path =~ %r{#{self.class.prefix_path_to_ignore}}
            return true, path.gsub(self.class.prefix_path_to_ignore, '')
          else
            return false, path
          end
        end
        return true, path
      end

      def query_param(data)
        result = nil
        if data.is_a? String
          result = ''
          if data != ''
            result = '?'
            result.force_encoding('ASCII-8BIT')
            result << data
          end
        elsif data.is_a? Hash
          result = data.empty? ? '' : '?' + URI.encode_www_form(data)
        end
        return result
      end
    end
  end
end
