class TransactionsController < ApplicationController
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
    respond_with(@transaction)
  end

  def edit
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.save
    respond_with(@transaction)
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
