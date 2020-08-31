class ContentController < ApplicationController

    def index
        render json: { contents: [] }
    end

    def recommended
        render json: { contents: [] }
    end
end
