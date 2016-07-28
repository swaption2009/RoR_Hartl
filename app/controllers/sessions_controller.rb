class SessionsController < ApplicationController
  def new
  
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		if user.activated?
        flash[:success] = "Welcome to the app"
    		log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    		redirect_back_or user
      else
        flash[:warning] = "Account not activated. Check your email for the activation link."
        redirect_to root_url
      end
    else
  		flash.now[:danger] = "The email password combination did not match."
  		render :new
  	end
  end

  def destroy
  	flash[:success] = "You have been logged out"
  	logout if logged_in?
  	redirect_to root_path
  end
end
