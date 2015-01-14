class AccountsController < ApplicationController
  before_filter :set_account, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @accounts = Account.all
    respond_with(@accounts)
  end

  def show
    respond_with(@account)
  end

  def new
    @account = Account.new
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = Account.new(params[:account])
    @account.save
    respond_with(@account)
  end

  def update
    @account.update_attributes(params[:account])
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end
end
