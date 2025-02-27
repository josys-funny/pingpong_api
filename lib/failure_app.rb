# frozen_string_literal: true

class FailureApp < Devise::FailureApp
  def respond
    json_error_response
  end

  private

  def json_error_response
    self.status = :unauthorized
    self.content_type = 'application/json'
    self.response_body = { error: 'Invalid login credentials' }.to_json
  end
end
