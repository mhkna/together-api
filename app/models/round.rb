class Round < ApplicationRecord
  has_many :accounts

  def account_ids
    self.accounts.pluck(:id)
  end
end
