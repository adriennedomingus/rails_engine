class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.joins(invoices: :transactions)
      .where(transactions: { result: 'success' })
      .where(invoices: { customer_id: self.id} )
      .group(:id)
      .order('transactions.count DESC')
      .first
  end
end
