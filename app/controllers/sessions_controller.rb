class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if @user
      login(@user)
      render 'users/show'
    else
      render json: ["Invalid email and/or password"], status: 401
    end
  end

  def destroy
    @user = current_user

    if @user
      logout
      render '/users/show'
    else
      render json: ["No one is currently logged in"], status: 404
    end
  end

end
