require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TransactionsController, :type => :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "http://test.hostwhere_i_came_from"
  end

  # This should return the minimal set of attributes required to create a valid
  # Transaction. As you add validations to Transaction, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    #skip("Add a hash of attributes valid for your model")
    {:first_direction => "To", :first_account_id => "1", :second_direction => "To", :second_account_id => "2", :amount => 0}
  }

  let(:invalid_attributes) {
    #skip("Add a hash of attributes invalid for your model")
    {:first_direction => "0", :first_account_id => "To", :second_direction => "1", :second_account_id => "To", :amount => "xx"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TransactionsController. Be sure to keep this updated too.
  let(:valid_session) { {:first_direction => "To", :first_account_id => "1", :second_direction => "To", :second_account_id => "2", :amount => 0} }

  describe "GET index" do
    login_user
    it "assigns all transactions as @transactions" do
      transaction = Transaction.create! valid_attributes
      get :index, {}
      expect(assigns(:transactions)).to eq([transaction])
    end
  end

  describe "GET show" do
    login_user
    it "assigns the requested transaction as @transaction" do
      transaction = Transaction.create! valid_attributes
      get :show, {:id => transaction.to_param}
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe "GET new" do
    login_user
    it "assigns a new transaction as @transaction" do
      get :new, {}
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe "GET edit" do
    login_user
    it "assigns the requested transaction as @transaction" do
      transaction = Transaction.create! valid_attributes
      get :edit, {:id => transaction.to_param}
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe "POST create" do
    login_user
    describe "with valid params" do
      it "creates a new Transaction" do
        account_double = double('Account')
        account_double.stub(:validate_transaction).and_return(true)
        Account.should_receive(:validate_transaction).and_return(true)
        expect {
          post :create, {:transaction => valid_attributes}
        }.to change(Transaction, :count).by(1)
      end

      it "assigns a newly created transaction as @transaction" do
        account_double = double('Account')
        account_double.stub(:validate_transaction).and_return(true)
        Account.should_receive(:validate_transaction).and_return(true)
        post :create, {:transaction => valid_attributes}
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted
      end

      it "redirects to the created transaction" do
        account_double = double('Account')
        account_double.stub(:validate_transaction).and_return(true)
        Account.should_receive(:validate_transaction).and_return(true)
        post :create, {:transaction => valid_attributes}
        expect(response).to redirect_to(Transaction)
      end

      it "redirects to the form to try again" do
        account_double = double('Account')
        account_double.stub(:validate_transaction).and_return(false)
        Account.should_receive(:validate_transaction).and_return(false)
        post :create, {:transaction => valid_attributes}
        expect(response).to redirect_to(:back)
      end

      it "redirects to the form to try again as account amount is not sufficient" do
        account_double1 = double('Asset')
        account_double1.stub(:id).and_return(1)
        account_double1.stub(:amount).and_return("100")
        account_double2 = double('Equity')
        account_double2.stub(:id).and_return(1)
        account_double2.stub(:amount).and_return(2)
        Account.should_receive("find_by_id").and_return(account_double1)
        #Account.should_receive(:find_by_id).and_return(account_double2)
        post :create, {:transaction => {:first_direction => "From", :first_account_id => account_double1.id, :second_direction => "To", :second_account_id => account_double2.id, :amount => 1000}}
        expect(response).to redirect_to(:back)
      end

    end

  end

  describe "PUT update" do
    login_user
    describe "with valid params" do
      let(:new_attributes) {
        {:first_direction => "To", :first_account_id => "1", :second_direction => "To", :second_account_id => "2", :amount => 100}
      }

      it "updates the requested transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => new_attributes}
        transaction.reload
        #skip("Add assertions for updated state")
      end

      it "assigns the requested transaction as @transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => valid_attributes}
        expect(assigns(:transaction)).to eq(transaction)
      end

      it "redirects to the transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => valid_attributes}
        expect(response).to redirect_to(transaction)
      end
    end

  end

  describe "DELETE destroy" do
    login_user
    it "destroys the requested transaction" do
      transaction = Transaction.create! valid_attributes
      expect {
        delete :destroy, {:id => transaction.to_param}
      }.to change(Transaction, :count).by(-1)
    end

    it "redirects to the transactions list" do
      transaction = Transaction.create! valid_attributes
      delete :destroy, {:id => transaction.to_param}
      expect(response).to redirect_to(transactions_url)
    end
  end

end
