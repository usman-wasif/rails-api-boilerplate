module Api
  module V1
    module Concerns
      module Authenticator
        extend ActiveSupport::Concern
        include DeviseTokenAuth::Concerns::SetUserByToken
        included do
          before_action :authenticate_api_v1_user!
          skip_before_action :authenticate_api_v1_user!, if: :devise_controller?
          skip_before_action :authenticate_api_v1_user!, only: :status
        end

        def current_user
          current_api_v1_user
        end

        def user_signed_in?
          current_user.present?
        end

        def auth_with_token!
          head :unauthorized unless user_signed_in?
        end
      end
    end
  end
end
