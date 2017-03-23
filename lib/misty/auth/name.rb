module Misty
  class Auth
    module Domain
      attr_accessor :domain

      def identity
        data = {}
        if !id.nil?
          data.merge!(to_h(:id))
        elsif !name.nil? && !domain.nil?
          data.merge!(to_h(:name))
          data.merge!({ :domain => @domain.identity })
        else
          raise Misty::Auth::CredentialsError, "#{self.class}: An Id, or a name with its domain, must be provided"
        end
        data
      end
    end

    class Name < Struct.new(:id, :name)
      def identity
        return to_h(:id) unless id.nil?
        return to_h(:name) unless name.nil?
        raise Misty::Auth::CredentialsError, "#{self.class}: No available id or name"
      end

      def to_h(var)
        { var => self.send(var) }
      end
    end

    class DomainScope < Name
      def identity
        { :domain => super }
      end
    end

    class ProjectScope < Name
      include Misty::Auth::Domain

      def identity
        { :project => super }
      end
    end

    class User < Name
      include Misty::Auth::Domain

      attr_accessor :password

      def identity
        data = super
        raise Misty::Auth::CredentialsError, "#{self.class}: No password available" if password.nil?
        data.merge!(to_h(:password))
        { :user => data }
      end
    end
  end
end
