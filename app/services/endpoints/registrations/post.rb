module Endpoints
  module Registrations
    class Post
      prepend SimpleCommand

      attr_reader :password, :email, :params
      attr_accessor :user

      def initialize(params: {})
        @params = params
        @password = params[:password]
        @email = params[:email]
      end

      def call
        @user = User.new(params)

        validations

        return if errors.present?

        user.ensure_authentication_token
        if user.save
          { status: 'ok', auth_token: user.authentication_token }
        else
          error_message
        end
      end

      private

      def error_message
        user.errors.full_messages.each do |error|
          errors.add(:base, error)
        end
      end

      def validations
        password_validation && email_validation
      end

      def password_validation
        errors.add(:base, 'Invalid Email or Password.') unless user.valid_password?(password)
      end

      def email_validation
        errors.add(:base, 'Invalid Email or Password.') unless email.nil?
      end
    end
  end
end
