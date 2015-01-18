class Account < ActiveRecord::Base
  attr_accessible :name, :accounttype, :amount
end
