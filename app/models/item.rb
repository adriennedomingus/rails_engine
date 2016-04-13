class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.ranked_by_revenue
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .order('SUM(invoice_items.unit_price * invoice_items.quantity) DESC')
  end
end
