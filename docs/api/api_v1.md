API title
=========
**Version:** 0.0.1

### /v1/timestamp
---
##### ***GET***
**Description:** Get server current unix timestamp.

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Get server current unix timestamp. |

### /v1/accounts/expense
---
##### ***POST***
**Description:** Create Expense Account

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | formData | Account name. | Yes | string |
| base_currency | formData | Account Base Currency. | No | string |
| month_expenses_limit | formData | Account Month Expense Limit. | No | double |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | Create Expense Account | [ExpenseAccount](#expenseaccount) |

##### ***GET***
**Description:** Get Expense Accounts for user

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Get Expense Accounts for user | [ [ExpenseAccount](#expenseaccount) ] |

### /v1/accounts/keep
---
##### ***POST***
**Description:** Create Keep Account

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | formData | Account name. | Yes | string |
| base_currency | formData | Account Base Currency | No | string |
| initial_balance | formData | Initial Balance to be put on Account. | No | double |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 201 | Create Keep Account | [KeepAccount](#keepaccount) |

##### ***GET***
**Description:** Get Keep Accounts for user

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Get Keep Accounts for user | [ [KeepAccount](#keepaccount) ] |

### /v1/incomes
---
##### ***POST***
**Description:** Record User income

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| account_name | formData | Account name where income will be recorded to. | Yes | string |
| amount | formData | Income amount. | Yes | double |
| description | formData | Income operation description. | No | string |
| date | formData | Income operation time. | No | dateTime |

**Responses**

| Code | Description |
| ---- | ----------- |
| 201 | Record User income |

##### ***GET***
**Description:** Get User incomes

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| account_name | query | Account name for filtering incomes. | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Get User incomes | [ [Income](#income) ] |

### /v1/rates
---
##### ***GET***
**Description:** Get currency rates

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| base | query |  | Yes | string |
| quote | query |  | Yes | string |

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Get currency rates |

### /v1/expenses
---
##### ***POST***
**Description:** Record User expense

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| keep_account_name | formData | Keep Account name which will be debited. | Yes | string |
| expense_account_name | formData | Expense Account name which will be credited. | Yes | string |
| base_amount | formData | Amount in Keep Account currency. | Yes | double |
| quote_amount | formData | Amount in Expense Account currency. | No | double |
| description | formData | Expense operation description. | No | string |
| date | formData | Expense operation time. | No | dateTime |

**Responses**

| Code | Description |
| ---- | ----------- |
| 201 | Record User expense |

##### ***GET***
**Description:** Get User Expenses

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| keep_account_name | query | Keep account name for filtering expenses. | No | string |
| expense_account_name | query | Expense account name for filtering expenses. | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Get User Expenses | [ [Expense](#expense) ] |

### /v1/balances
---
##### ***GET***
**Description:** Get user balances

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Get user balances |

### Models
---

### ExpenseAccount  

Get Expense Accounts for user

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| name | string | Account Name | No |
| base_currency | string | Account Base Currency | No |
| balance | string | Account Current Balance | No |
| user_uid | string | User Uniq ID | No |
| month_expenses_limit | string | Account Month Expenses Limit | No |

### KeepAccount  

Get Keep Accounts for user

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| name | string | Account Name | No |
| base_currency | string | Account Base Currency | No |
| balance | string | Account Current Balance | No |
| user_uid | string | User Uniq ID | No |

### Income  

Get User incomes

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| amount | string | Income Amount. | No |
| currency | string | Income Currency. | No |
| keep_account | string | Keep Account Name. | No |
| description | string | Income Transaction description. | No |
| recorded_at | string | Income Transaction date | No |

### Expense  

Get User Expenses

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| base_amount | string | Expense Amount in Keep Account Currency. | No |
| base_currency | string | Currency of Keep Account. | No |
| quote_amount | string | Expense Amount in Expense Account Currency. | No |
| quote_currency | string | Currency of Expense Account. | No |
| keep_account | string | Keep Account Name. | No |
| expense_account | string | Expense Account Name. | No |
| description | string | Expense Transaction description. | No |
| recorded_at | string | Expense Transaction date | No |