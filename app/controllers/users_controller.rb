class UsersController < ApplicationController
  skip_before_action :authenticate_request

  # POST /users
  # POST /users.json
  def create
    user = User.create(user_params)
    if user.errors.blank?
      data = { message: I18n.t('user.create.success') }
      render json: data
      return
    end

    data = {error: { message: user.errors.full_messages.join(', ') }}
    render json: data, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
