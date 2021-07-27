class UsersController < ApplicationController

    def create
        #create the user
        # user = User.create!(params.require(:user).permit(:username, :password, :password_confirmation))
        user = User.create!(params.permit(:username, :password, :password_confirmation))
        #save the user id in the session hash
        session[:user_id] = user.id
        #get info back to the frontend
        render json: user, status: :created
      #rescue method
      rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "Not authorized"}, status: :unauthorized
        end
    #   rescue ActiveRecord::RecordNotFound
    #     render json: {error: "User not found"}, status: :not_found
    end

end

# username,
# password,
# password_confirmation: passwordConfirmation,