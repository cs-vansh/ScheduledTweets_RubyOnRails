class RegistrationsController < ApplicationController
    def new
      # instance variable will be visible in views, normal variable (without @) will be visible only in this method itself
      @user = User.new
    end

    def create
      # params could either come from the URL(like grabbing a part of it) or else in the case of forms, it is that params will contain the data sent in the form

      # not secure to do this.
      # @user = User.new(params[:user])

      # secure way to do it (user_params is a private method)
      @user = User.new(user_params)
      if @user.save
        # Lives until the browser is closed (or expiry set).
        # values of cookies can be changed but sessions can't be tampered with.
        session[:user_id] = @user.id

        redirect_to root_path, notice: "Account Creation Successful. Welcome to Scheduled Tweets!"
      else

        # will go to app/views/registrations/new.html.erb
        render :new
      end
      # render plain: params # gives {"authenticity_token" => "PcRKQLltlOC2i7oz67SfxPmYAbraFGQfLxlir7pX6aL4HaKjYy2A3l-VRuVYH1gNN5bYpZAog1gZqcmkyAHDnw", "user" => {"email" => "test@test", "password" => "qwerty", "password_confirmation" => "qwerty"}, "commit" => "Sign Up", "controller" => "registrations", "action" => "create"}
      # render plain: params[:user] # gives only the user part {"email" => "test@test", "password" => "qwerty", "password_confirmation" => "qwerty"}
    end

    private

    def user_params
      # Will give error if user not found
      # permit will only allow to set these values(even if there is some admin flag, the user won't be able to set it)
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
