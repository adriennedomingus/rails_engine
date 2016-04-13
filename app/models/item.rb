class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.ranked_by_revenue
    select('id', 'name', 'SUM(invoice_items.unit_price * invoice_items.quantity) AS total_item_revenue')
      .joins(invoice_items: [:invoice, :transactions])
      .where(transactions: { result: "success"})
      .group(:id)
      .reorder('total_item_revenue DESC')
  end
end
