require 'rails_helper'

RSpec.describe TransferMoneyService, type: :model do
  describe '#call' do
    let(:sender) { create(:user) }
    let!(:sender_account) { create(:account, balance: 1_000, user: sender) }

    let(:receiver) { create(:user) }
    let!(:receiver_account) { create(:account, balance: 0, user: receiver) }

    it 'subtract sender money, add receiver money, create both transactions' do
      TransferMoneyService.new(sender, receiver, 500).call

      expect(sender_account.balance).to eq(500)
      expect(receiver_account.balance).to eq(500)

      sender_transaction = Transaction.find_by(account_id: sender_account.id)
      expect(sender_transaction.initial_balance).to eq(1000)
      expect(sender_transaction.final_balance).to eq(500)
      expect(sender_transaction.sender_id).to eq(sender.id)
      expect(sender_transaction.receiver_id).to eq(receiver.id)
      expect(sender_transaction.status).to eq('completed')

      receiver_transaction = Transaction.find_by(account_id: receiver_account.id)
      expect(receiver_transaction.initial_balance).to eq(0)
      expect(receiver_transaction.final_balance).to eq(500)
      expect(receiver_transaction.sender_id).to eq(sender.id)
      expect(receiver_transaction.receiver_id).to eq(receiver.id)
      expect(receiver_transaction.status).to eq('completed')
    end
  end
end
