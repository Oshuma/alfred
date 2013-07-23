module Alfred
  module AppHelpers
    def check_auth_token!
      return unless Alfred.config.auth_token

      auth_token = request.env['HTTP_X_AUTH_TOKEN']

      error 401 if auth_token.nil?
      error 401 unless auth_token == Alfred.config.auth_token
    end

    def check_basic_auth!
      return unless Alfred.config.username

      self.class.use Rack::Auth::Basic, "Restricted Area" do |username, password|
        (username == Alfred.config.username) && (password == Alfred.config.password)
      end
    end

    def ensure_api_enabled!
      check_auth_token!
      error 404 unless Alfred.config.enable_api
    end

    def ensure_web_enabled!
      check_basic_auth!
      error 404 unless Alfred.config.enable_web
    end
  end
end
