module ValidatesCaptcha
  class MiddlewareWrapper
    RECOGNIZED_RESPONSE_STATUS_CODES = [200, 422].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      result = ValidatesCaptcha.provider.call(env)

      return @app.call(env) unless RECOGNIZED_RESPONSE_STATUS_CODES.include?(result.first)

      result
    end
  end
end

