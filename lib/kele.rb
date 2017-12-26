require 'httparty'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    @api_url = "https://www.bloc.io/api/v1"
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

  def get_mentor_availability(mentor_id)
    mentor_id = 1329746
    response = Kele.get(
      "#{@api_url}/mentors/1329746/student_availability",
      headers: { "authorization" => @auth_token }
      )
      JSON.parse(response.body)
  end

  def get_roadmap(roadmap_id)
    roadmap_id = 38
    response = Kele.get(
      "#{@api_url}/roadmaps/38",
      headers: { "authorization" => @auth_token }
      )
      JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    checkpoint_id = 2265
    response = Kele.get(
      "#{@api_url}/checkpoints/2265",
      headers: { "authorization" => @auth_token }
      )
      JSON.parse(response.body)
  end
end
