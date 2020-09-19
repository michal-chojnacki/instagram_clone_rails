class Image
    include ActiveModel::Model
    include Rails.application.routes.url_helpers

    attr_accessor :url

    def image=(value)
        if value.attached?
            @url = ENV['IMAGES_ROOT'] + rails_blob_path(value, only_path:true)
        else
            @url = ""
        end
    end

    def as_json(options = {})
        super.except("_routes")
    end
end