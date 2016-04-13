class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.total_revenue_by_date(date)
    revenue = where(created_at: date)
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price')
    { total_revenue: revenue }
  end
end
