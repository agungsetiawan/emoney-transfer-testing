FactoryBot.define do
  factory :transaction do
    amount { 1 }
    initial_balance { 1 }
    final_balance { 1 }
    sender_id { 1 }
    receiver_id { 1 }
    account_id { 1 }
    status { "MyString" }
  end
end
