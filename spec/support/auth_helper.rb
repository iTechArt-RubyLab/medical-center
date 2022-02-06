module AuthHelper
  def current_user
    user = create :user

    {
      Authorization: user.authentication_token
    }
  end
end
