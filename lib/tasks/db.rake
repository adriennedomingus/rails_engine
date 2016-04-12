require 'csv'

namespace :db do
  task import_csv: :environment do
    CSV.foreach('./app/assets/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end

    CSV.foreach('./app/assets/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('./app/assets/data/items.csv', headers: true) do |row|
      unit_price = sprintf('%.2f', row["unit_price"].to_f/100.0).to_f
      Item.create(id:          row["id"],
                  name:        row["name"],
                  description: row["description"],
                  unit_price:  unit_price,
                  merchant_id: row["merchant_id"],
                  created_at:  row["created_at"],
                  updated_at:  row["updated_at"])
    end

    CSV.foreach('./app/assets/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('./app/assets/data/invoice_items.csv', headers: true) do |row|
      unit_price = sprintf('%.2f', row["unit_price"].to_f/100.0).to_f
      InvoiceItem.create(id:         row["id"],
                      item_id:    row["item_id"],
                      invoice_id: row["invoice_id"],
                      quantity:   row["quantity"],
                      unit_price: unit_price,
                      created_at: row["created_at"],
                      updated_at: row["updated_at"])
    end

    CSV.foreach('./app/assets/data/transactions.csv', headers: true) do |row|
      Transaction.create(id:                row["id"],
                        invoice_id:         row["invoice_id"],
                        credit_card_number: row["credit_card_number"],
                        result:             row["result"],
                        created_at:         row["created_at"],
                        updated_at:         row["updated_at"])
    end
  end
end
