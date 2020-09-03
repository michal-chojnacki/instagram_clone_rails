require 'json'

class UserController < ApplicationController

    def get_user
        render json: @current_user.as_json
    end

    def update
        avatar = params[:avatar]
        @current_user.avatar.attach(avatar)
        render json: { status: "ok" }
    end

    def get_likes
        favourites_contents = @current_user.favourites_contents
        statuses = JSON.parse(params[:ids]).map{ |x| [x, favourites_contents.find_by_id(x) != nil] }.to_h
        render json: { statuses: statuses }
    end

    def add_like
        content = Content.find_by_id(params[:contentId])
        render json: { errors: "Content not found" }, status: :not_found  if content == nil

        if params[:status]
            content.favourites_users << @current_user if content.favourites_users.find_by_id(@current_user) == nil
        elsif 
            content.favourites_users.delete(@current_user)
        end
        render json: { status: "ok" }
    end
end