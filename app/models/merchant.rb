class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.ranked_by_revenue
    select('id', 'name', 'SUM(invoice_items.unit_price * invoice_items.quantity) AS total_merchant_revenue')
      .joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success"})
      .group(:id)
      .reorder('total_merchant_revenue DESC')
  end

  def self.ranked_by_items_sold
    select('id', 'name', 'SUM(invoice_items.quantity) AS total_items_sold')
      .joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success" })
      .group(:id)
      .reorder('total_items_sold DESC')
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

  # def customers_with_pending_invoices
  #   Customer.joins(:invoices).joins(:transactions).where(invoices: { merchant_id: self.id}).where(transactions: { result: "failed" }).uniq
  # end

  def customers_with_pending_invoices
    invoices.joins(:transactions).where(transactions: {result: "failed"}).map do |invoice|
      invoice.customer
    end.uniq
  end
end
