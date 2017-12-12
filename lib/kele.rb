require 'httparty'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    @api_url = "https://www.bloc.io/api/v1"

    @auth = {email: email, password: password}
    @auth_token = "https://www.bloc.io/api/v1/sessions"
    response = Kele.post(@auth_token, body: {email: email, password: password})
    @auth_token = response["auth_token"]
  end

  def get_me
    response = Kele.get(
            "#{@api_url}/users/me",
      headers: { "authorization" => @auth_token }
    )
    JSON.parse(response.body)
  end
end