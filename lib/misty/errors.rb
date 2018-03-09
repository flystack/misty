module Misty
  module Auth
    class AuthenticationError < StandardError; end
    class InitError < RuntimeError; end

    module Catalog
      class EndpointError < StandardError; end
      class ServiceTypeError < StandardError; end
    end

    module Token
      class ExpiryError      < RuntimeError; end
      class URLError         < RuntimeError; end
    end

    module V2
      class CredentialsError < RuntimeError; end
    end

    module V3
      class DomainScopeError < RuntimeError; end
    end
  end

  class Config
    class CredentialsError < RuntimeError; end
    class InvalidDataError < StandardError; end
  end

  module HTTP
    class Header
      class ArgumentError < RuntimeError; end
      class TypeError     < RuntimeError; end
    end
  end

  module Microversion
    class VersionError < RuntimeError; end
  end
end
