class TransferMoneyService
  def initialize(sender, receiver, amount)
    @sender   = sender
    @receiver = receiver
    @amount   = amount
  end

  def call
    sender_account   = sender.account
    receiver_account = receiver.account

    ActiveRecord::Base.transaction do
      sender_initial_balance = sender_account.balance
      sender_final_balance   = sender_initial_balance - amount
      sender_account.update!(balance: sender_final_balance)

      receiver_initial_balance = receiver_account.balance
      receiver_final_balance   = receiver_initial_balance + amount
      receiver_account.update!(balance: receiver_final_balance)

      Transaction.create!(amount: amount,
                          initial_balance: sender_initial_balance,
                          final_balance: sender_final_balance,
                          sender_id: sender.id,
                          receiver_id: receiver.id,
                          account_id: sender_account.id,
                          status: 'completed'
                         )

      Transaction.create!(amount: amount,
                          initial_balance: receiver_initial_balance,
                          final_balance: receiver_final_balance,
                          sender_id: sender.id,
                          receiver_id: receiver.id,
                          account_id: receiver_account.id,
                          status: 'completed'
                         )
    end
  end

  private

  attr_reader :sender, :receiver, :amount
end
