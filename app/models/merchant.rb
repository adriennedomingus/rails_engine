class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.ranked_by_revenue
    joins(invoices: [:transactions, :invoice_items])
      .where(transactions: { result: "success" })
      .group(:id)
      .order('SUM(invoice_items.unit_price * invoice_items.quantity) DESC')
  end

  def self.ranked_by_items_sold
    joins(invoices: [:transactions, :invoice_items])
    .where(transactions: { result: "success"} )
    .group(:id)
    .order('SUM(invoice_items.quantity) DESC')
  end

  def total_revenue
    revenue = invoices.joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success"})
      .where(invoices: { merchant_id: self.id})
      .sum('invoice_items.unit_price * invoice_items.quantity')
    { revenue: revenue }
  end

  def items_sold
    invoices
    .joins(invoice_items: [:invoice, :transactions])
    .where(transactions: {result: "success"})
    .sum('invoice_items.quantity')
  end

  def total_revenue_by_date(date)
    revenue = invoices.joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success"})
      .where(invoices: { merchant_id: self.id})
      .where(invoices: { created_at: date})
      .sum('invoice_items.unit_price * invoice_items.quantity')
    { revenue: revenue }
  end

  def customers_with_pending_invoices
    Customer.where(id: invoices.pending.pluck(:customer_id))
  end

  def favorite_customer
    Customer.joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: 'success' })
      .where(invoices: { merchant_id: self.id} )
      .group(:id)
      .order('transactions.count DESC')
      .first
  end
end
