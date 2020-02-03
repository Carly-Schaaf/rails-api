class UsersController < ApplicationController
    def create
        @user = User.create(user_params)

        if @user.save
            login(@user)
            render :show
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def show 
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password2, :user_type)
    end

end
