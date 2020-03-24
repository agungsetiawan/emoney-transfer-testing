require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#priority_user?' do
    it 'return true if balance more than User::PRIORITY_USER_MINIMUM_BALANCE' do
      user    = create(:user)
      account = create(:account, balance: 200_000, user: user)

      expect(user.priority_user?).to eq(true)
    end

    it 'return false if balance less than User::PRIORITY_USER_MINIMUM_BALANCE' do
      user    = create(:user)
      account = create(:account, balance: 50_000, user: user)

      expect(user.priority_user?).to eq(false)
    end
  end
end
