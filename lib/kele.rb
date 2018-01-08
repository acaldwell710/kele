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

  def get_messages
    response = Kele.get(
      "#{@api_url}/message_threads",
      headers: { "authorization" => @auth_token }
      )
      JSON.parse(response.body)
  end

  def create_message(sender, recepient_id, subject, text, token)
    #  a9adfc07517c46b98462f31b85809b46 <- possible token
    #  sender: "acaldwell710@gmail.com",
    #  recepient_id: 1329746,
    #  /new?user_id=1329746
    #if token == nil
    #response = self.class.post("#{@api_url}/messages", body: {
    #  sender: sender,
    #  recepient_id: recepient_id,
    #  subject: subject,
    #  text: text},
    #  headers: {"authorization" => @auth_token})
    #else
    response = self.class.post("#{@api_url}/messages/", body: {
      sender: sender,
      recepient_id: recepient_id,
      token: token,
      subject: subject,
      text: text},
      headers: {"authorization" => @auth_token})
      # ^ Internal Server Error
    #end
      #@auth_token = response["auth_token"] <- gives 'nil'
      #JSON.parse(response.body) <- gives 'resource not found'
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    # 36133
    response = self.class.post("#{@api_url}/checkpoint_submissions", body: {
      checkpoint_id: checkpoint_id,
      assignment_branch: assignment_branch,
      assignment_commit_link: assignment_commit_link,
      comment: comment,
      enrollment_id: enrollment_id},
      headers: {"authorization" => @auth_token})
  end
end
