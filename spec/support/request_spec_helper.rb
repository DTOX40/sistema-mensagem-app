module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def auth_headers(user)
    user.create_new_auth_token
  end

  def authenticated_header(user)
    user.create_new_auth_token
  end
end
