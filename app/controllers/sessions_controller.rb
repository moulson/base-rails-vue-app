class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { error: "Rate limited" }, status: :unauthorized }

  def create
    if user = User.authenticate_by(login_params)
      session = user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip)
      render json: { token: session.token }, status: :created
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def show
    render json: { user: user }, status: :ok
  end

  def destroy
    terminate_session
    render json: { message: "Logged out" }, status: :ok
  end

  private

  def login_params
    params.require(:user).permit(:email_address, :password)
  end
end
