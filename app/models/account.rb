class Account < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :round

  validates_presence_of :website, :username
end
