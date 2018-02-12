class ApplicationController < ActionController::API

  before_action :authenticate_user!

  protected
  def authenticate_user!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    Session.find_by(user: auth_token['id'], token: http_token).touch
    @current_user = User.find(auth_token['id'])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
    if request.headers['HTTP_AUTH_TOKEN'].present?
      request.headers['HTTP_AUTH_TOKEN'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token['id']
  end

end
