# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    super { |resource| @resource = resource }
  end
end
