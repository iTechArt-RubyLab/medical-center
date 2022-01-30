module AuthHelper
  def headers(user)
    {
      Authorization: user.authentication_token
    }
  end
end
