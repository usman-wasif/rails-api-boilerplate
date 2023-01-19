module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def reservation_attributes(with_invalid_date: false)
    @reservation_attributes =
      {
        reservation:
          attributes_for(:reservation).merge({
            vehicle_id: vehicle_id,
            customer_attributes: attributes_for(:customer)
          })
      }

    @reservation_attributes[:reservation][:date] = Faker::Date.between(from: 2.days.ago, to: Date.today).to_s if with_invalid_date

    @reservation_attributes
  end
end

