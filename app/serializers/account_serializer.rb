class AccountSerializer < ActiveModel::Serializer
  attributes :id, :website, :username, :matched_accounts
  has_many :comments
  def comments
    self.object.comments.map do |comment|
      {text: comment.text,
       created_at: comment.created_at}
    end
  end
  def matched_accounts
    self.object.matched_accounts(2).map do |account|
      {username: account.username}
    end
  end
  #def round
  #  {round_id: self.object.round.id}
  #end
end
