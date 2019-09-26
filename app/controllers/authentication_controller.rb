require 'json_web_token'

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      jwt = JsonWebToken.encode(user_id: user.id)

      render json: {
        user: user.slice(:id, :name, :email),
        jwt: jwt,
        message: I18n.t('authentication.success')}
    else
      render json: {
        error: { message: I18n.t('authentication.failure') }
      }, status: 401
    end
  end
end
