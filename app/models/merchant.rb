class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def total_revenue
    revenue = 0
    self.invoices.each do |invoice|
      invoice.transactions.where(result: "success").each do |transaction|
        transaction.invoice.invoice_items.each do |invoice_item|
          revenue += (invoice_item.quantity * invoice_item.unit_price)
        end
      end
    end
    { revenue: revenue.to_f.to_s }
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
end
