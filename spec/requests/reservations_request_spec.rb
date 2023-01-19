RSpec.describe 'Reservations', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:vehicle_id) { create(:vehicle).id }

  describe 'new user session' do
    context 'with valid request' do
      before { login }

      it 'should sign in user' do
        expect(json["data"]["email"]).to eq(user.email)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid request' do
      before { login(email: 'wrong@email.com') }

      it 'should return a validation failure message' do
        expect(response.body).to include(
          I18n.t('errors.invalid_login_credentials')
        )
      end
    end
  end

  describe 'Reservations' do
    context 'with valid request' do
      before do
        login
        @auth_params = get_auth_params_from_login_response_headers(response)
      end

      it 'should get all reservations' do
        get '/api/v1/reservations', headers: @auth_params
        expect(json.size).to eq(0)
      end

      it 'should create reservation' do
        create_reservation
        expect(response).to have_http_status(201)
      end

      it 'should fetch reservation' do
        reservation = create_reservation
        get api_v1_reservation_path(reservation), headers: @auth_params
        expect(json['id']).to eq(reservation.id)
      end

      it 'should update reservation' do
        reservation = create_reservation
        patch api_v1_reservation_path(reservation), headers: @auth_params, params: reservation_attributes
        expect(response).to have_http_status(200)
      end

      it 'should destroy reservation' do
        reservation = create_reservation
        delete api_v1_reservation_path(reservation), headers: @auth_params
        expect(response).to have_http_status(204)
      end
    end

    context 'with invalid request' do
      before do
        login
        @auth_params = get_auth_params_from_login_response_headers(response)
      end

      it 'should give invalid date error on creation' do
        create_reservation(with_invalid_date: true)
        expect(json['errors']['date']).to include(I18n.t('errors.invalid_date'))
      end

      it 'should not be able to find reservation to show' do
        get api_v1_reservation_path(Faker::Number.number(digits: 10)), headers: @auth_params
        expect(json['error']).to include(I18n.t('errors.reservation_not_found'))
      end

      it 'should give invalid date error on updation' do
        reservation = create_reservation
        patch api_v1_reservation_path(reservation), headers: @auth_params, params: reservation_attributes(with_invalid_date: true)
        expect(json['errors']['date']).to include(I18n.t('errors.invalid_date'))
      end

      it 'should not be able to find reservation to destroy' do
        delete api_v1_reservation_path(Faker::Number.number(digits: 10)), headers: @auth_params
        expect(json['error']).to include(I18n.t('errors.reservation_not_found'))
      end
    end
  end

  private

  def get_auth_params_from_login_response_headers(response)
    response.headers.slice(
      'client',
      'access-token',
      'uid',
      'expiry',
      'token-type'
    )
  end

  def login(email: nil)
    post api_v1_user_session_path, params:  { email: (email || user.email), password: 112233 }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def create_reservation(with_invalid_date: false)
    post api_v1_reservations_path, headers: @auth_params, params: reservation_attributes(with_invalid_date: with_invalid_date)
    response.status == 201 ? Reservation.first : nil
  end
end
