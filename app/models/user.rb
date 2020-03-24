class User < ApplicationRecord
  has_one :account

  PRIORITY_USER_MINIMUM_BALANCE = 100_000

  def priority_user?
    account.balance > PRIORITY_USER_MINIMUM_BALANCE
  end
end
