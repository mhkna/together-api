class AccountSerializer < ActiveModel::Serializer
  attributes :id, :website, :username, :matched_info

  # def comments
  #   self.object.comments.map do |comment|
  #     {text: comment.text,
  #      created_at: comment.created_at}
  #   end
  # end
  def matched_info
    self.object.matched_accounts(1).map do |account|
      {username: account.username,
       comment: account.comments.first.text}
    end
  end
  #def round
  #  {round_id: self.object.round.id}
  #end
end
