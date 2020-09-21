class ApplicationController < ActionController::API
    before_action :verify_api_key
    before_action :authorize_request, except: [:sign_in]

    def verify_api_key  
      if request.headers['ApiKey'] != ENV['MOBILE_APP_KEY']
        render json: { errors: "Unauthorized request"}, status: :unauthorized
      end
    end

    def authorize_request   
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          decoded = JsonWebToken.decode(header)
          @current_user = User.find(decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end
end
