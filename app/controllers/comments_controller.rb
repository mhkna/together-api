class CommentsController < ApplicationController
  before_action :set_account
  before_action :set_account_comment, only: [:show, :update, :destroy]

  # GET /accounts/:account_id/comments
  def index
    json_response(@account.comments)
  end

  # GET /accounts/:account_id/comments/:id
  def show
    json_response(@comment)
  end

  # POST /accounts/:account_id/comments
  def create
    @account.comments.create!(comment_params)
    json_response(@account, :created)
  end

  # PUT /accounts/:account_id/comments/:id
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /accounts/:account_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

    def comment_params
      params.permit(:text)
    end

    def set_account
      @account = Account.find(params[:account_id])
    end

    def set_account_comment
      @comment = @account.comments.find_by!(id: params[:id]) if @account
    end
end
