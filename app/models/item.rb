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

  def self.ranked_by_number_sold
    joins(invoice_items: :transactions)
      .where(transactions: { result: "success" })
      .group(:id)
      .order('SUM(invoice_items.quantity) DESC')
  end

  def best_day
    result = invoices.select('invoices.created_at')
      .joins(:transactions)
      .where(transactions: { result: "success" })
      .group(:created_at)
      .order('SUM(invoice_items.unit_price * invoice_items.quantity) DESC')
    { best_day: result.first.created_at}
  end
end
