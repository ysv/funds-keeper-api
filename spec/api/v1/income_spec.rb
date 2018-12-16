describe API::V1::Account, 'GET /api/v1/incomes', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:data) { {} }

  subject do
    api_get '/api/v1/incomes', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 200 }

  context 'multiple incomes ' do
    let!(:incomes) do
      create_list(:income, 5)
    end

    let(:uid_keep_accounts) { create_list(:keep_account, 3, user_uid: uid)}
    let!(:uid_incomes) do
      create_list(:income, 10, keep_account: uid_keep_accounts.sample)
    end

    it 'returns all mine incomes' do
      expect(response_body.count).to eq uid_incomes.count
      expect(response_body.count).to eq Income.where(keep_account: uid_keep_accounts).count
    end

    context 'filter' do
      let(:keep_account) { uid_keep_accounts.sample }

      before do
        data.merge!(account_name: keep_account.name)
      end

      it 'return all mine incomes by account' do
        expect(response_body.count).to eq \
          Income.where(keep_account: keep_account).count
      end
    end
  end
end

describe API::V1::Account, 'POST /api/v1/incomes', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:uid_keep_account) { create(:keep_account, user_uid: uid)}
  let(:data) do
    {
      account_name: uid_keep_account.name,
      amount: generate(:income_amount)
    }
  end

  subject do
    api_post '/api/v1/incomes', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 201 }

  it 'creates income for account' do
    expect{subject}.to change{uid_keep_account.incomes.count}.by(1)
  end

  context 'with description' do
    let(:description){ Faker::Lorem.sentence }
    before do
      data.merge!(description: description)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates income with description' do
      expect(response_body[:description]).to eq description
    end
  end

  context 'keep account doesn\'t exist' do
    before do
      data.merge!(account_name: Faker::Bank.unique.name)
    end

    it { is_expected.to have_http_status 400 }

    it 'doesn\'t create create income' do
      expect(response_body[:error]).to include('Couldn\'t find KeepAccount')
    end
  end
end

