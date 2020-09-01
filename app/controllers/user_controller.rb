require 'json'

class UserController < ApplicationController

    def get_user
        render json: current_user.as_json
    end

    def update
        avatar = params[:avatar]
        current_user.avatar.attach(avatar)
        render json: { status: "ok" }
    end

    def get_likes
        statuses = JSON.parse(params[:ids]).map{ |x| [x, false] }.to_h
        render json: { statuses: statuses }
    end
end