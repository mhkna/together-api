module V1
  class AccountsController < ApplicationController
    before_action :set_account, only: [:show, :update, :destroy]

    def index
      @accounts = current_user.accounts.paginate(page: params[:page], per_page: 20)
      json_response(@accounts)
    end

    def create
      @account = current_user.accounts.create!(account_params)
      json_response(@account, :created)
    end

    def show
      json_response(@account)
    end

    def update
      @account.update(account_params)
      head :no_content
    end

    def destroy
      @account.destroy
      head :no_content
    end

    private

      def account_params
        params.permit(:website, :username, :round_id)
      end

      def set_account
        @account = Account.find(params[:id])
      end
  end
end
