module Accounts
  class Keep < Account

  end
end

# == Schema Information
# Schema version: 20181202200448
#
# Table name: keeps
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)      not null
#  user_uid      :string(25)       not null
#  base_currency :string(10)       default("usd"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_keeps_on_name_and_user_uid  (name,user_uid) UNIQUE
#
