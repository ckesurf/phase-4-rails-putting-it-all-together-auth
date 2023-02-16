class SessionsController < ApplicationController
  def create
    # find the user (with the creds in form)
    logged_in_user = User.find_by!(username: params[:username])
    # params[:username]
    # params[:password]
    # authenicate the user with the password they provided
    if logged_in_user.authenticate(params[:password])
      # if so, update the session hash
      session[:user_id] = logged_in_user.id 
      render json: logged_in_user
    else
      # if not, yell at you
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
    
  end

  def destroy
    if session[:user_id]
      session.delete :user_id
    else 
      # return an error
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end
end
