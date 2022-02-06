class ErrorHandler < Grape::Middleware::Base
  def call!(env)
    @env = env
    begin
      @app.call(@env)
    rescue StandardError => e
      throw :error, message: e.message || options[:default_message], status: 500
    end
  end
end
