module AuthHelper
  def http_login
    user = create :user

    {
      Authorization: user.authentication_token
    }
  end
end
