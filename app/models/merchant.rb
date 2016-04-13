class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.ranked_by_revenue
    select('id', 'name', 'SUM(invoice_items.unit_price * invoice_items.quantity) AS total_merchant_revenue')
      .joins(invoice_items: [:invoice, :transactions])
      .where("result = ?", "success")
      .group(:id)
      .reorder('total_merchant_revenue DESC')
  end

  def self.ranked_by_items_sold
    all.sort_by { |merchant| merchant.items_sold }.reverse
  end

  def total_revenue
    revenue = invoices.joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success"})
      .where(invoices: { merchant_id: self.id})
      .sum('invoice_items.unit_price * invoice_items.quantity')
    { revenue: revenue.to_f.to_s}
  end

  def items_sold
    items_sold = 0
    self.invoices.each do |invoice|
      invoice.transactions.where(result: "success").each do |transaction|
        transaction.invoice_items.each do |invoice_item|
          items_sold += invoice_item.quantity
        end
      end
    end
    items_sold
  end

  def total_revenue_by_date(date)
    revenue = 0
    self.invoices.where(created_at: date).each do |invoice|
      invoice.transactions.where(result: "success").each do |transaction|
        transaction.invoice.invoice_items.each do |invoice_item|
          revenue += (invoice_item.quantity * invoice_item.unit_price)
        end
      end
    end
    { revenue: revenue.to_f.to_s }
  end

  # def customers_with_pending_invoices
  #   Customer.joins(:invoices).joins(:transactions).where(invoices: { merchant_id: self.id}).where(transactions: { result: "failed" }).uniq
  # end

  def customers_with_pending_invoices
    invoices.joins(:transactions).where("result = ?", "failed").map do |invoice|
      invoice.customer
    end.uniq
  end
end
