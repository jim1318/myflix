class ForgotPasswordsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user
      SendPasswordResetEmail.perform_async(user.id)
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = params[:email].blank? ? "Email cannot be blank" : "Incorrect Email" 
      redirect_to forgot_password_path
    end
  end

  def confirm
    
  end

end