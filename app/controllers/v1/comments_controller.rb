module V1
  class CommentsController < ApplicationController
    before_action :set_account
    before_action :set_account_comment, only: [:show, :update, :destroy]

    def index
      json_response(@account.comments)
    end

    def show
      json_response(@comment)
    end

    def create
      @account.comments.create!(comment_params)
      json_response(@account, :created)
    end

    def update
      @comment.update(comment_params)
      head :no_content
    end

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
end
