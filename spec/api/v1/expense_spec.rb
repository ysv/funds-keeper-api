describe API::V1::Account, 'GET /api/v1/expenses', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:data) { {} }

  subject do
    api_get '/api/v1/expenses', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 200 }

  context 'multiple expenses ' do
    let!(:expenses) do
      create_list(:expense, 5)
    end

    let(:uid_keep_accounts) { create_list(:keep_account_with_balance, 3, user_uid: uid)}
    let(:uid_expense_category) { create_list(:expense_category, 3, user_uid: uid)}

    let!(:uid_expenses) do
      create_list(
        :expense,
        10,
        keep_account: uid_keep_accounts.sample,
        expense_category: uid_expense_category.sample
      )
    end

    it 'returns all mine expenses' do
      expect(response_body.count).to eq uid_expenses.count
      expect(response_body.count).to eq \
        Expense.where(expense_category: uid_expense_category, keep_account: uid_keep_accounts).count
    end

    context 'filter by keep account' do
      let(:keep_account) { uid_keep_accounts.sample }

      before do
        data.merge!(keep_account_name: keep_account.name)
      end

      it 'return all mine expenses by keep account' do
        expect(response_body.count).to eq \
          Expense.where(keep_account: keep_account).count
      end
    end

    context 'filter by expense account' do
      let(:expense_category) { uid_expense_category.sample }

      before do
        data.merge!(expense_account_name: expense_category.name)
      end

      it 'return all mine expenses by expense account' do
        expect(response_body.count).to eq \
          Expense.where(expense_category: expense_category).count
      end
    end
  end
end

describe API::V1::Account, 'POST /api/v1/expenses', type: :request do
  let(:uid) { Faker::Auth.uid }
  let(:token) { jwt_for(uid) }
  let(:uid_keep_account) { create(:keep_account_with_balance, user_uid: uid)}
  let(:uid_expense_account) { create(:expense_category, user_uid: uid)}
  let(:data) do
    {
      keep_account_name: uid_keep_account.name,
      expense_account_name: uid_expense_account.name,
      base_amount: generate(:expense_amount),
      quote_amount: generate(:expense_amount)
    }
  end

  subject do
    api_post '/api/v1/expenses', params: data, token: token
    response
  end

  let(:response_body) { JSON.parse(subject.body).deep_symbolize_keys }

  it { is_expected.to have_http_status 201 }

  it 'creates expense for keep account' do
    expect{subject}.to change{uid_keep_account.expenses.count}.by(1)
  end

  it 'creates expense for expense category' do
    expect{subject}.to change{uid_expense_account.expenses.count}.by(1)
  end

  context 'with description' do
    let(:description){ Faker::Lorem.sentence }
    before do
      data.merge!(description: description)
    end

    it { is_expected.to have_http_status 201 }

    it 'creates expense with description' do
      expect(response_body[:description]).to eq description
    end
  end

  context 'keep account doesn\'t exist' do
    before do
      data.merge!(keep_account_name: Faker::Bank.unique.name)
    end

    it { is_expected.to have_http_status 400 }

    it 'doesn\'t create create expense' do
      expect(response_body[:error]).to include('Couldn\'t find KeepAccount')
    end
  end

  context 'expense account doesn\'t exist' do
    before do
      data.merge!(expense_account_name: Faker::Bank.unique.name)
    end

    it { is_expected.to have_http_status 400 }

    it 'doesn\'t create create expense' do
      expect(response_body[:error]).to include('Couldn\'t find ExpenseCategory')
    end
  end
end
