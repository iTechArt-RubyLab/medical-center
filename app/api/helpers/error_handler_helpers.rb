module Helpers
  module ErrorHandlerHelpers
    def render_not_found(error)
      error!(error.message, 404)
    end

    def params_missing(error)
      error!(error.message, 400)
    end

    def validation_error(error)
      error!(error.message, 422)
    end

    def argument_error(error)
      error!(error.message, 400)
    end

    def record_invalid(error)
      error!(error.message, 400)
    end
  end
end
