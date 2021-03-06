require 'rails_helper'

RSpec.describe Account, :type => :model do
  describe 'validate transaction' do
    it 'valid add to Asset and Equity' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Asset", :amount => 0)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Equity", :amount => 0)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 100).should eq(true)
    end

    it 'invalid add to Asset and Expense!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Asset", :amount => 0)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Expense", :amount => 0)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 100).should eq(false)
    end

    it 'invalid add from Asset to Equity!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Asset", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Equity", :amount => 100)

      Account.validate_transaction(account1.id, "From", account2.id, "To", 100).should eq(false)
    end

    it 'invalid add to Asset and Liability!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Asset", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Liability", :amount => 100)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 200).should eq(true)
    end

    it 'valid withdraw from Asset and Liability!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Asset", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Liability", :amount => 100)

      Account.validate_transaction(account1.id, "From", account2.id, "From", 100).should eq(true)
    end

    it 'invalid add to Expense and Asset!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Expense", :amount => 0)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Asset", :amount => 0)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 100).should eq(false)
    end

    it 'invalid add from Equity to Asset!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Equity", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Asset", :amount => 100)

      Account.validate_transaction(account1.id, "From", account2.id, "To", 100).should eq(false)
    end

    it 'valid add to Liability and Asset!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Liability", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Asset", :amount => 100)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 200).should eq(true)
    end

    it 'valid add to Equity and Expense!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Equity", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Expense", :amount => 100)

      Account.validate_transaction(account1.id, "To", account2.id, "To", 200).should eq(true)
    end

    it 'valid withdraw from both Equity and Expense!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Equity", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Expense", :amount => 100)

      Account.validate_transaction(account1.id, "From", account2.id, "From", 50).should eq(true)
    end

    it 'valid withdraw from both Liability and Expense!' do
      account1 = FactoryGirl.create(:account, :name => "First", :accounttype => "Liability", :amount => 100)
      account2 = FactoryGirl.create(:account, :name => "Second", :accounttype => "Expense", :amount => 100)

      Account.validate_transaction(account1.id, "From", account2.id, "From", 100).should eq(true)
    end

  end
end
