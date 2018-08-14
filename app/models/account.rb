class Account < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :round
  belongs_to :user

  validates_presence_of :website, :username

  def matched_accounts(num_of_accounts)
    self.class.where("id >= ? AND id <= ?", low_matched_id(num_of_accounts), high_matched_id)
  end

  private

    def high_matched_id
      high_index = account_id_index - 1
      round_account_ids[high_index]
    end

    def low_matched_id(offset)
      low_index = account_id_index - offset
      round_account_ids[low_index]
    end

    def account_id_index
      round_account_ids.index(self.id)
    end

    def round_account_ids
      self.round.accounts.pluck(:id)
    end
end
