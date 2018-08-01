class Comment < ApplicationRecord
  belongs_to :account

  validates_presence_of :text
end
