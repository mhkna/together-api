class Account < ApplicationRecord
  has_many :comments, dependent: :destroy
  #has_many :matched_accounts, through: :round
  belongs_to :round
  belongs_to :user

  validates_presence_of :website, :username
  # 
  # def matched_accounts
  #   account = self.round.account_ids
  # end
end
