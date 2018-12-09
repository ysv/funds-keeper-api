describe API::V1::Account, 'GET /api/v1/accounts/keep', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }

  subject do
    api_get '/api/v1/accounts/keep', token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 200 }

  context 'multiple keep accounts' do
    let!(:other_keep_accounts) do
      create_list(:keep_account_with_balance, 5)
    end

    let!(:uid_keep_accounts) do
      create_list(:keep_account_with_balance, 3, user_uid: uid)
    end

    it 'returns all mine keep accounts' do
      expect(response_body.count).to eq uid_keep_accounts.count
      expect(response_body.pluck(:user_uid)).to all eq(uid)
    end

    it 'returns keep accounts with not zero balance' do
      expect(response_body.pluck(:balance).map(&:to_d)).to all be > 0
    end
  end
end
