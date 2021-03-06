require 'json'

class UserController < ApplicationController

    def get_user
        if params[:user] != nil
            user = User.find(params[:user])
        else
            user = @current_user
        end
        render json: user.as_json
    end

    def update
        if @current_user.update(params.permit(:bio, :username, :fullname))
            @current_user.avatar.attach(params[:avatar]) if(params[:avatar] != nil)
            render json: { status: "ok" }
        else
            render json: { errors: "Something went wrong" }, status: :error
        end        
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

    def get_following_status
        userId = params[:user]
        followed_user = @current_user.followees.find_by_id(userId)
        render json: { status: followed_user != nil, userId: followed_user.id }
    end

    def change_following_status
        followed_user = User.find_by_id(params[:userId])
        render json: { errors: "Content not found" }, status: :not_found  if followed_user == nil

        if params[:status]
            followed_user.followers << @current_user if followed_user.followers.find_by_id(@current_user) == nil
        elsif 
            followed_user.followers.delete(@current_user)
        end
        render json: { status: "ok" }
    end

    def get_recommended_users
        render json: { users: User.select { |user| user != @current_user && user.followers.find_by_id(@current_user) == nil }.take(30) }
    end

    def get_followers
        page = params[:page].to_i
        userId = params[:user].to_i
        data = User.find_by_id(userId).followers
        render json: { users: data.page(page + 1),
          page: page,
          pages: data.count / WillPaginate.per_page + 1  }
    end

    def get_followees
        page = params[:page].to_i
        userId = params[:user].to_i
        data = User.find_by_id(userId).followees
        render json: { users: data.page(page + 1),
          page: page,
          pages: data.count / WillPaginate.per_page + 1  }
    end
end