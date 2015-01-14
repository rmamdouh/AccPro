class Account < ActiveRecord::Base
  attr_accessible :amount, :name, :type
end
