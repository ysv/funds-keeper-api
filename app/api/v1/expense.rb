module API::V1
  class Expense < Grape::API
    desc 'Get User Expenses',
         is_array: true,
         success: Entities::Expense
    params do
      optional :keep_account_name,
               type: String,
               desc: 'Keep account name for filtering expenses.'
      optional :expense_account_name,
               type: String,
               desc: 'Expense account name for filtering expenses.'
    end
    get '/expenses' do
      ka = KeepAccount.where(user_uid: uid)
      ec = ExpenseCategory.where(user_uid: uid)
      ka = ka.where(name: params[:keep_account_name]) if params[:keep_account_name].present?
      ec = ec.where(name: params[:expense_account_name]) if params[:expense_account_name].present?
      present ::Expense.where(keep_account: ka, expense_category: ec),
              with: Entities::Expense
    end

    desc 'Record User expense',
         success: Entities::Expense
    params do
      requires :keep_account_name,
               type: String,
               desc: 'Keep Account name which will be debited.'
      requires :expense_account_name,
               type: String,
               desc: 'Expense Account name which will be credited.'
      requires :base_amount,
               type: BigDecimal,
               desc: 'Amount in Keep Account currency.',
               values: 0.to_d..10**10.to_d
      optional :quote_amount,
               type: BigDecimal,
               desc: 'Amount in Expense Account currency.',
               values: 0.to_d..10**10.to_d
      optional :description,
               type: String,
               default: '',
               desc: 'Expense operation description.'
      optional :date,
               type: Time,
               default: ->{ Time.now },
               desc: 'Expense operation time.'
    end
    post '/expenses' do
      ka = KeepAccount.find_by!(user_uid: uid, name: params[:keep_account_name])
      ec = ExpenseCategory.find_by!(user_uid: uid, name: params[:expense_account_name])

      ec.transaction do
        expense = ::Expense.create!(
          description: params[:description],
          recorded_at: params[:date],
          keep_account: ka,
          expense_category: ec)

        expense.record_operations!(
          base_amount: params[:base_amount],
          quote_amount: params[:quote_amount]
        )
        present expense, with: Entities::Expense
      end
    end
  end
end
