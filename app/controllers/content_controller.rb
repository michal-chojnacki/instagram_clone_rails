class ContentController < ApplicationController
  def index
    page = params[:page].to_i
    render json: { contents: Content.order("created_at DESC").page(page + 1),
                   page: page,
                   pages: Content.count / WillPaginate.per_page + 1 }
  end

  def recommended
    page = params[:page].to_i
    data = Content.order("created_at DESC").where.not(:user => @current_user)
    render json: { contents: data.page(page + 1),
      page: page,
      pages: data.count / WillPaginate.per_page + 1  }
  end

  def search_content
    page = params[:page].to_i
    query = params[:query]
    data = Content.where("description like ?", "%#{query}%")
    render json: { contents: data.page(page + 1),
      page: page,
      pages: data.count / WillPaginate.per_page + 1  }
  end

  def add
    content = Content.create(description: params[:message], user: @current_user)
    content.image.attach(params[:image])
    render json: { status: "ok" }
  end

  def get_user_content
    page = params[:page].to_i
    if (params[:user] == nil)
      user = @current_user
    elsif user = User.find(params[:user])
    end
    data = user.contents.order("created_at DESC")
    render json: { contents: data.page(page + 1),
      page: page,
      pages: data.count / WillPaginate.per_page + 1  }
  end
end
