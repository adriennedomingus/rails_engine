class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.ranked_by_revenue
    all.sort_by { |merchant| merchant.total_revenue[:revenue].to_f }.reverse
  end

  def self.ranked_by_items_sold
    result = all.sort_by do |merchant|
      merchant.items_sold
    end.reverse
  end

  def total_revenue
    revenue = 0
    self.invoices.each do |invoice|
      invoice.transactions.where(result: "success").each do |transaction|
        transaction.invoice_items.each do |invoice_item|
          revenue += (invoice_item.quantity * invoice_item.unit_price)
        end
      end
    end
    { revenue: revenue.to_f.to_s }
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

  def customers_with_pending_invoices
    customers = []
    self.invoices.each do |invoice|
      invoice.transactions.each do |transaction|
        if transaction.result == "failed"
          customers << transaction.invoice.customer
        end
      end
    end
    customers.uniq
  end
end
