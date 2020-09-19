class ContentController < ApplicationController
  def index
    render json: { contents: Content.order("created_at DESC").all() }
  end

  def recommended
    render json: { contents: Content
             .order("created_at DESC")
             .select { |content| content.user != @current_user } }
  end

  def add
    content = Content.create(description: params[:message], user: @current_user)
    content.image.attach(params[:image])
    render json: { status: "ok" }
  end

  def get_user_content
    if (params[:user] == nil)
      user = @current_user
    elsif 
      user = User.find(params[:user])
    end
    render json: { contents: user.contents.order("created_at DESC") }
  end
end
