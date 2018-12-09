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
| base_currency | formData |  | No | string |
| month_expense | formData |  | No | double |

**Responses**

| Code | Description |
| ---- | ----------- |
| 201 | Create Expense Account |

##### ***GET***
**Description:** Get Expense Accounts for user

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Get Expense Accounts for user |

### /v1/accounts/keep
---
##### ***POST***
**Description:** Create Keep Account

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| name | formData | Account name. | Yes | string |
| base_currency | formData |  | No | string |
| initial_balance | formData |  | No | double |

**Responses**

| Code | Description |
| ---- | ----------- |
| 201 | Create Keep Account |

##### ***GET***
**Description:** Get Keep Accounts for user

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | Get Keep Accounts for user | [ [KeepAccount](#keepaccount) ] |

### /v1/income
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

| Code | Description |
| ---- | ----------- |
| 200 | Get User incomes |

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

### /v1/expense
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

| Code | Description |
| ---- | ----------- |
| 200 | Get User Expenses |

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

### KeepAccount  

Get Keep Accounts for user

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| name | string | Account Name | No |
| base_currency | string | Account Base Currency | No |
| balance | double | Account Current Balance | No |
| user_uid | string | User Uniq ID | No |