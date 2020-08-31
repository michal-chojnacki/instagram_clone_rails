class UserController < ApplicationController

    def get_user
        render json: current_user.as_json
    end

    def update
        avatar = params[:avatar]
        current_user.avatar.attach(avatar)
        render json: { status: "ok" }
    end

    private

    def current_user
        User.first
    end
end