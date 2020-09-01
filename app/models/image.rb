class Image
    include ActiveModel::Model
    include Rails.application.routes.url_helpers

    attr_accessor :url

    def image=(value)
        @url = "http://10.0.2.2:3000" + rails_blob_path(value, only_path:true)
    end

    def as_json(options = {})
        super.except("_routes")
    end
end