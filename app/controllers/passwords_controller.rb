class PasswordsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  before_action :set_user_by_token, only: %i[ edit ]
  before_action :set_user, only: %i[update]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if User.authenticate_by({ email_address: @user.email_address, password: params[:password][:current_password] })
      if @user.update({ password: params[:password][:new_password], password_confirmation: params[:password][:new_password_confirmation] })
        render json: { message: "Password updated" }, status: :ok
      else
        render json: { message: "Passwords do not match" }, status: :unprocessable_entity
      end
    else
      render json: { message: "Password incorrect" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: unprocessable_entity
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end

    def set_user
      @user = Current.user
    end

    def update_password_params
      params.permit(:current_password, :new_password, :new_password_confirmation)
    end
end
