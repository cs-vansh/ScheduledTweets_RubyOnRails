class MainController < ApplicationController

  def index
    flash[:notice] = "Logged in successfully. Welcome to Scheduled Tweets"
    flash[:alert] = "Invalid email or password"
  end

end