class AuthenticateController < ApplicationController
    def sign_in
        username = params[:authenticate][:username]
        username = params[:authenticate][:password]
        render json: { token: "token" }
    end
end
