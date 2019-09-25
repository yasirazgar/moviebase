require 'json_web_token'

class UsersController < ApplicationController
  skip_before_action :authenticate_request

  # POST /users
  # POST /users.json
  def create
    user = User.create(user_params)
    if user.errors.blank?
      jwt = JsonWebToken.encode(user_id: user.id)

      data = {
        user: user.slice(:name, :email),
        jwt: jwt,
        message: I18n.t('user.create.success')
      }

      render json: data
      return
    end
byebug
    data = {error: { message: user.errors.full_messages.join(', ') }}
    render json: data, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
