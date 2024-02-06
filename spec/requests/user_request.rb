require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST api_v1_signup' do
    # let!(:user) { create(:user) }
    # it 'status 201' do

    # end
  end

  describe 'GET /api/v1/users' do
    it 'satus 200' do
      get '/api/v1/users'
      expect(response.status).to eq(200)
    end
  end
end
