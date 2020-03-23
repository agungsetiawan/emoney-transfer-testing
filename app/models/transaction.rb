class Transaction < ApplicationRecord
  belongs_to :account

  def completed?
    status == 'completed'
  end

  def pending?
    status == 'pending'
  end

  def failed?
    status == 'failed'
  end
end
