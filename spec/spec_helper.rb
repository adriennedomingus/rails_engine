require 'simplecov'
SimpleCov.start

module SpecHelpers

  def create_three_merchants
    m1 = Merchant.create(name: "name")
    m2 = Merchant.create(name: "name2")
    m3 = Merchant.create(name: "name3")
    [m1, m2, m3]
  end

  def create_three_customers
    c1 = Customer.create(first_name: "Adrienne", last_name: "Domingus")
    c2 = Customer.create(first_name: "Chelsea", last_name: "Johnson")
    c3 = Customer.create(first_name: "Scott", last_name: "Firestone")
    [c1, c2, c3]
  end

  def create_five_items_per_merchant
    create_three_merchants.each do |merchant|
      num = 0
      5.times do
        merchant.items.create(name: "itemname#{num}", description: "item description")
        num += 1
      end
    end
  end

  def create_invoices
    create_five_items_per_merchant
    create_three_customers.each do |customer|
      Merchant.all.each do |merchant|
        3.times do
          customer.invoices.create(merchant_id: merchant.id, status: "shipped")
        end
      end
    end
  end

  def create_invoice_items
    create_invoices
    price = 2
    quantity = 1
    Invoice.all.each do |invoice|
      invoice.invoice_items.create(item_id: Random.rand(Item.first.id..Item.last.id), quantity: quantity, unit_price: price)
      price += 2
      quantity += 2
    end
  end

  def create_transactions
    create_invoice_items
    Invoice.all.each do |invoice|
      Transaction.create(invoice_id: invoice.id, credit_card_number: "12345678910", result: "success")
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecHelpers
end
