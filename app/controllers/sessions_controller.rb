class SessionsController < ApplicationController

    #this use cookies to let user stay login 
    def create
        #user the stored cookies to find the user 
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end
end
