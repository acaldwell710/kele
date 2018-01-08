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

  def get_messages(number)
    response = Kele.get(
      "#{@api_url}/message_threads",
      headers: { "authorization" => @auth_token }
      )
      JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, text, token)
    # 375e39df-9016-45f9-b7b5-27a9a8454e66 <- token
    if token == nil
      response = self.class.post("#{@api_url}/messages", body: {
        sender: sender,
        recepient_id: recepient_id,
        subject: subject,
        text: text},
        headers: {"authorization" => @auth_token})
    else
      response = self.class.post("#{@api_url}/messages", body: {
        sender: sender,
        recipient_id: recipient_id,
        subject: subject,
        text: text,
        token: token},
        headers: {"authorization" => @auth_token})
    end
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    # 36133 <- enrollment_id
    response = self.class.post("#{@api_url}/checkpoint_submissions", body: {
      checkpoint_id: checkpoint_id,
      assignment_branch: assignment_branch,
      assignment_commit_link: assignment_commit_link,
      comment: comment,
      enrollment_id: enrollment_id},
      headers: {"authorization" => @auth_token})
  end
end
