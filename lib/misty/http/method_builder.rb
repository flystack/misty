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

      def process_data(header, args)
        if args.size == 1 && Misty.json_encode?(args[0])
          header.add('Content-Type' => 'application/json')
          return Misty.to_json(args[0])
        end
      end

      def method_call(method, *args)
        if args[-1].class == Misty::HTTP::Header
          header = Misty::HTTP::Header.new(@headers.get.clone)
          header.add(args.pop.get)
        else
          header = @headers
        end

        base, path = prefixed_path(method[:path])
        size_path_parameters = count_path_params(path)
        path_params = args[0, size_path_parameters]
        args_left = args - path_params
        path = inject_elements(path, path_params)
        final_path = base_filter(base, path)

        case method[:request]
        when :COPY
          http_copy(final_path, header.get)
        when :DELETE
          http_delete(final_path, header.get)
        when :GET
          final_path << query_param(args_left.shift) if args_left && args_left.size == 1
          http_get(final_path, header.get)
        when :HEAD
          http_head(final_path, header.get)
        when :POST
          final_path << query_param(args_left.shift) if args_left && args_left.size == 2
          data = process_data(header, args_left)
          http_post(final_path, header.get, data)
        when :PUT
          final_path << query_param(args_left.shift) if args_left && args_left.size == 2
          data = process_data(header, args_left)
          http_put(final_path, header.get, data)
        when :PATCH
          final_path << query_param(args_left.shift) if args_left && args_left.size == 2
          data = process_data(header, args_left)
          http_patch(final_path, header.get, data)
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
        api.each do |path, verbs_list|
          verbs_list.each do |verb, methods|
            if methods.include?(name)
              return {:path => path, :request => verb, :name => name}
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
        unless prefix_path_to_ignore.empty?
          if path =~ %r{#{prefix_path_to_ignore}}
            return true, path.gsub(prefix_path_to_ignore, '')
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
