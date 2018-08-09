class AccountSerializer < ActiveModel::Serializer
  attributes :id, :website, :username
  has_many :comments
  def comments
    self.object.comments.map do |comment|
      {text: comment.text,
       created_at: comment.created_at}
    end
  end
end
