describe API::V1::Account, 'GET /accounts/keep', type: :request do
  let(:token) { jwt_for('uid') }


  it 'requires authentication' do
    api_get '/api/v1/accounts/keep'
    expect(response.status).to eq 401
  end
end
