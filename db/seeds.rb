
ACCOUNTS  = [["Cash", "Asset", 0], 
["Bank", "Asset", 0],
["Equipment", "Asset", 0],
["Accounts Receivable", "Asset", 0],
["Accounts Payable", "Liability", 0],
["Debt", "Liability", 0],
["Office Expenses", "Expense", 0],
["Project Expenses", "Expense", 0],
["Capital", "Equity", 0],
["Revenue", "Equity", 0]]

ACCOUNTS.each do |account|
   Account.create(name: account[0], accounttype: account[1], amount: account[2])
end

