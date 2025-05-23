class MainController < ApplicationController
  def index
    # flash[:notice] = "Logged in successfully. Welcome to Scheduled Tweets"
    # flash[:alert] = "Invalid email or password"


    # CODE MOVED TO APPLICATION CONTROLLER TO SHARE WITH ALL CONTROLLERS
    # if session[:user_id]
    #   # find throws an error when user is not found
    #   # @user = User.find(session[:user_id])

    #   # find_by returns nil when user is not found, instead of throwing an error
    #   @user = User.find_by(id: session[:user_id])
    # else
    #   @user = nil
    # end
    

  end
end
