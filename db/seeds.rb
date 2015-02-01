
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

ADMIN = ["admin@admin.com", "12345678", "12345678"]
USER = ["user@user.com", "12345678", "12345678"]

ACCOUNTS.each do |account|
   Account.create(name: account[0], accounttype: account[1], amount: account[2])
   User.create(email: ADMIN[0], password: ADMIN[1], password_confirmation: ADMIN[2], admin: true)
   User.create(email: USER[0], password: USER[1], password_confirmation: USER[2], admin: false)
end

