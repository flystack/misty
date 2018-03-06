module Misty
  module Auth
    class AuthenticationError < StandardError; end
    class CatalogError        < StandardError; end
    class TokenError          < StandardError; end

    class ExpiryError      < RuntimeError; end
    class InitError        < RuntimeError; end
    class URLError         < RuntimeError; end
  end

  class Config
    class CredentialsError < RuntimeError; end
    class InvalidDataError < StandardError; end
  end

  module Microversion
    class VersionError < RuntimeError; end
  end
end
