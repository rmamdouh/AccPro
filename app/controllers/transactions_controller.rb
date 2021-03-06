class TransactionsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_transaction, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @transactions = Transaction.all
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction)
  end

  def new
    @transaction = Transaction.new
    @accounts = Account.all
    @direction_menu = [["From", "From"], ["To", "To"]]
    @account_menu = []
    @accounts.each do |account|
      @account_menu << [account.name, account.id]
    end
    respond_with(@transaction)
  end

  def edit
    @transaction = Transaction.find_by_id(params[:id])
    @accounts = Account.all
    @direction_menu = [["From", "From"], ["To", "To"]]
    @account_menu = []
    @accounts.each do |account|
      @account_menu << [account.name, account.id]
    end
    respond_with(@transaction)
  end

  def create
    @valid = false

    if ( ( (params[:transaction][:first_direction] == "From") and 
        (Account.find_by_id(params[:transaction][:first_account_id]).amount.to_i < params[:transaction][:amount].to_i) ) or
        ((params[:transaction][:second_direction] == "From") and 
        (Account.find_by_id(params[:transaction][:second_account_id]).amount.to_i < params[:transaction][:amount].to_i)) )
      flash[:notice] = "No enough money in your account."
      redirect_to :back
    else
      @valid = Account.validate_transaction(params[:transaction][:first_account_id], 
                                          params[:transaction][:first_direction], 
                                          params[:transaction][:second_account_id], 
                                          params[:transaction][:second_direction], 
                                          params[:transaction][:amount])
    if (@valid == true)
      @transaction = Transaction.new(params[:transaction])
      @transaction.save
      redirect_to transactions_path
    else
      flash[:notice] = "Transaction is invalid, please use proper accounts."
      redirect_to :back
    end

    end
    
  end

  def update
    @transaction.update_attributes(params[:transaction])
    respond_with(@transaction)
  end

  def destroy
    @transaction.destroy
    respond_with(@transaction)
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
