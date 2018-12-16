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

describe API::V1::Account, 'POST /api/v1/accounts/keep', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:data) { { name: Faker::Bank.unique.name } }

  subject do
    api_post '/api/v1/accounts/keep', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 201 }

  it 'creates keep account' do
    expect(
      KeepAccount.exists?(user_uid: uid, name: response_body[:name])
    ).to be_truthy
  end

  it 'creates keep account for user' do
    expect(response_body[:user_uid]).to eq uid
  end

  context 'with base currency' do
    before do
      data.merge!(base_currency: :eur)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates account with custom currency' do
      ka = KeepAccount.find_by(user_uid: uid, name: response_body[:name])
      expect(response_body[:base_currency]).to eq 'eur'
      expect(ka.base_currency).to eq 'eur'
    end
  end

  context 'with initial balance' do
    before do
      data.merge!(initial_balance: 9876)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates account with initial balance' do
      ka = KeepAccount.find_by(user_uid: uid, name: response_body[:name])
      expect(response_body[:balance]).to eq 9876.to_d.to_s
      expect(ka.balance).to eq 9876.to_d
    end
  end

  context 'existing account' do
    let(:keep_account) { create(:keep_account_with_balance, user_uid: uid) }

    before do
      data.merge!(name: keep_account.name)
    end

    it { is_expected.to have_http_status 400 }

    it 'returns error message' do
      expect(response_body[:error]).to include('Name has already been taken')
    end
  end
end

describe API::V1::Account, 'GET /api/v1/accounts/expense', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }

  subject do
    api_get '/api/v1/accounts/expense', token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 200 }

  context 'multiple expense accounts' do
    let!(:other_expense_categories) do
      create_list(:expense_category_with_limit, 5)
    end

    let!(:uid_expense_categories) do
      create_list(:expense_category_with_limit, 3, user_uid: uid)
    end

    it 'returns all mine expense accounts' do
      expect(response_body.count).to eq uid_expense_categories.count
      expect(response_body.pluck(:user_uid)).to all eq(uid)
    end

    it 'returns expense accounts with not zero month limit' do
      expect(response_body.pluck(:month_expenses_limit).map(&:to_d)).to all be > 0
    end
  end
end

describe API::V1::Account, 'POST /api/v1/accounts/expense', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:data) { { name: Faker::Vehicle.unique.make_and_model } }

  subject do
    api_post '/api/v1/accounts/expense', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 201 }

  it 'creates expense category' do
    expect(
      ExpenseCategory.exists?(user_uid: uid, name: response_body[:name])
    ).to be_truthy
  end

  it 'creates expense category for user' do
    expect(response_body[:user_uid]).to eq uid
  end

  context 'with base currency' do
    before do
      data.merge!(base_currency: :eur)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates account with custom currency' do
      ka = ExpenseCategory.find_by(user_uid: uid, name: response_body[:name])
      expect(response_body[:base_currency]).to eq 'eur'
      expect(ka.base_currency).to eq 'eur'
    end
  end

  context 'with month expenses limit' do
    before do
      data.merge!(month_expenses_limit: 1234)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates account with initial balance' do
      ka = ExpenseCategory.find_by(user_uid: uid, name: response_body[:name])
      expect(response_body[:month_expenses_limit]).to eq 1234.to_d.to_s
      expect(ka.month_expenses).to eq 1234.to_d
    end
  end

  context 'existing account' do
    let(:expense_category) { create(:expense_category_with_limit, user_uid: uid) }

    before do
      data.merge!(name: expense_category.name)
    end

    it { is_expected.to have_http_status 400 }

    it 'returns error message' do
      expect(response_body[:error]).to include('Name has already been taken')
    end
  end
end
