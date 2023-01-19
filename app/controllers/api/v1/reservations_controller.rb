module Api
  module V1
    class ReservationsController < ApiController
      private
      def resource_params
        params.require(:reservation).permit(
          :date, :time, :vehicle_id,
          customer_attributes: [ :id, :first_name, :last_name, :email, :phone, :cms_customer_id ]
        )
      end
    end
  end
end
