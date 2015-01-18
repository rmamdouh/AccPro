class Account < ActiveRecord::Base
  attr_accessible :name, :accounttype, :amount

  def self.validate_transaction(account_1, account_1_direc, account_2, account_2_direc, amount)
    @asset = 0
    @expense = 0
    @liability = 0
    @equity = 0
    @accounts = Account.all

    @accounts.each do |account|
      if (account.accounttype == "Asset")
        @asset += account.amount.to_i
      elsif (account.accounttype == "Expense")
        @expense += account.amount.to_i
      elsif (account.accounttype == "Liability")
        @liability += account.amount.to_i
      elsif (account.accounttype == "Equity")
        @equity += account.amount.to_i
      end
    end

    if (self.find_by_id(account_1).accounttype == "Asset")
      if (account_1_direc == "To")
        @asset += self.find_by_id(account_1).amount.to_i
      elsif (account_1_direc == "From")
        @asset -= self.find_by_id(account_1).amount.to_i
      end
    elsif (self.find_by_id(account_1).accounttype == "Expense")
      if (account_1_direc == "To")
        @expense += self.find_by_id(account_1).amount.to_i
      elsif (account_1_direc == "From")
        @expense -= self.find_by_id(account_1).amount.to_i
      end
    elsif (self.find_by_id(account_1).accounttype == "Liability")
      if (account_1_direc == "To")
        @liability += self.find_by_id(account_1).amount.to_i
      elsif (account_1_direc == "From")
        @liability -= self.find_by_id(account_1).amount.to_i
      end
    elsif (self.find_by_id(account_1).accounttype == "Equity")
      if (account_1_direc == "To")
        @equity += self.find_by_id(account_1).amount.to_i
      elsif (account_1_direc == "From")
        @equity -= self.find_by_id(account_1).amount.to_i
      end
    end

    if (self.find_by_id(account_2).accounttype == "Asset")
      if (account_2_direc == "To")
        @asset += self.find_by_id(account_2).amount.to_i
      elsif (account_2_direc == "From")
        @asset -= self.find_by_id(account_2).amount.to_i
      end
    elsif (self.find_by_id(account_2).accounttype == "Expense")
      if (account_2_direc == "To")
        @expense += self.find_by_id(account_2).amount.to_i
      elsif (account_2_direc == "From")
        @expense -= self.find_by_id(account_2).amount.to_i
      end
    elsif (self.find_by_id(account_2).accounttype == "Liability")
      if (account_2_direc == "To")
        @liability += self.find_by_id(account_2).amount.to_i
      elsif (account_2_direc == "From")
        @liability -= self.find_by_id(account_2).amount.to_i
      end
    elsif (self.find_by_id(account_2).accounttype == "Equity")
      if (account_2_direc == "To")
        @equity += self.find_by_id(account_2).amount.to_i
      elsif (account_2_direc == "From")
        @equity -= self.find_by_id(account_2).amount.to_i
      end
    end

    if ( (@asset - @liability - @equity + @expense) == 0)
      if (account_1_direc == "To")
        Account.find_by_id(account_1).update_attributes(:amount => (amount.to_i + Account.find_by_id(account_1).amount.to_i))
      elsif (account_1_direc == "From")
        Account.find_by_id(account_1).update_attributes(:amount => (Account.find_by_id(account_1).amount.to_i - amount.to_i))
      end

      if (account_2_direc == "To")
        Account.find_by_id(account_2).update_attributes(:amount => (amount.to_i + Account.find_by_id(account_2).amount.to_i))
      elsif (account_2_direc == "From")
        Account.find_by_id(account_2).update_attributes(:amount => (Account.find_by_id(account_2).amount.to_i - amount.to_i))
      end

      return true
    else
      return false
    end
  end

end
