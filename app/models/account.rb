class Account < ApplicationRecord
  has_many :comments, dependent: :destroy
  #belongs_to :round
  belongs_to :user

  validates_presence_of :website, :username
end
