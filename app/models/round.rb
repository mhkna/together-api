class Round < ApplicationRecord
  has_many :accounts, dependent: :destroy
end
