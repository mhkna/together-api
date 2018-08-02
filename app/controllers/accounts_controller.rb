class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /accounts
  def index
    @accounts = current_user.accounts
    json_response(@accounts)
  end

  # POST /accounts
  def create
    @account = current_user.accounts.create!(account_params)
    json_response(@account, :created)
  end

  # GET /accounts/:id
  def show
    json_response(@account)
  end

  # PUT /accounts/:id
  def update
    @account.update(account_params)
    head :no_content
  end

  # DELETE /accounts/:id
  def destroy
    @account.destroy
    head :no_content
  end

  private

    def account_params
      params.permit(:website, :username)
    end

    def set_account
      @account = Account.find(params[:id])
    end
end
