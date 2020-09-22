class AuthenticateController < ApplicationController
    
    def sign_in
        username = params[:authenticate][:username]
        password = params[:authenticate][:password]
        user = User.find_by_username(username)
        if user != nil && user.authenticate(password)
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token }
        else
            render json: { errors: "User not authenticated" }, status: :unauthorized
        end
    end
 
    def sign_up
        username = params[:authenticate][:username]
        password = params[:authenticate][:password]
        user = User.find_by_username(username)
        if user == nil && User.create(username: username, password: password)
            user = User.find_by_username(username)
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token }
        else
            render json: { errors: "User not registered" }, status: :unauthorized
        end
    end
end
