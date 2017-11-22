module Misty
  module Auth
    class AuthenticationError < StandardError; end
    class CatalogError        < StandardError; end
    class TokenError          < StandardError; end

    class ExpiryError      < RuntimeError; end
    class CredentialsError < RuntimeError; end
    class InitError        < RuntimeError; end
    class URLError         < RuntimeError; end
  end
end
