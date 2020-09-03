class AuthenticateController < ApplicationController
    
    def sign_in
        username = params[:authenticate][:username]
        password = params[:authenticate][:password]
        user = User.find_by_username(username)
        if user != nil
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token }
        else
            render json: { errors: "User not found" }, status: :unauthorized
        end
    end
end
