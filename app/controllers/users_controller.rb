class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  def create
    user = User.new(user_params)

    if user.save
      session = user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip
      )
      render json: {
        token: session.token,
        user: user
        }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
