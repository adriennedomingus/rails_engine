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
      Item.create(row.to_h)
    end

    CSV.foreach('./app/assets/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('./app/assets/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
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
