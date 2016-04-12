require 'rails_helper'

RSpec.describe "Item invoice endpoint" do
  it "returns a hash of all item invoices" do
    m1 = Merchant.create(name: "merchant 1")
    m2 = Merchant.create(name: "merchant 2")
    item1 = m1.items.create(name: "item name", description: "item description", unit_price: 10.00)
    item2 = m1.items.create(name: "item 2 name", description: "item 2 description", unit_price: 20.00)
    item3 = m2.items.create(name: "item 3 name", description: "item 3 description", unit_price: 30.00)
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    invoice1 = customer.invoices.create(merchant_id: m1.id, status: "shipped")
    invoice2 = customer.invoices.create(merchant_id: m2.id, status: "shipped")
    customer2.invoices.create(merchant_id: m1.id, status: "shipped")
    customer.invoices.create(merchant_id: m2.id, status: "shipped")
    item1.invoice_items.create(invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price)
    item2.invoice_items.create(invoice_id: invoice2.id, quantity: 2, unit_price: item2.unit_price)
    item3.invoice_items.create(invoice_id: invoice1.id, quantity: 7, unit_price: item3.unit_price)

    get "/api/v1/invoice_items.json"
    result = JSON.parse(response.body)

    expect(result.first["item_id"]).to eq(item1.id)
    expect(result[1]["quantity"]).to eq(2)
    expect(result[2]["invoice_id"]).to eq(invoice1.id)
  end

  it "returns a specific item invoice" do
    m1 = Merchant.create(name: "merchant 1")
    m2 = Merchant.create(name: "merchant 2")
    item1 = m1.items.create(name: "item name", description: "item description", unit_price: 10.00)
    item2 = m1.items.create(name: "item 2 name", description: "item 2 description", unit_price: 20.00)
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    invoice1 = customer.invoices.create(merchant_id: m1.id, status: "shipped")
    invoice2 = customer.invoices.create(merchant_id: m2.id, status: "shipped")
    customer2.invoices.create(merchant_id: m1.id, status: "shipped")
    customer.invoices.create(merchant_id: m2.id, status: "shipped")
    ii1 = item1.invoice_items.create(invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price)
    item2.invoice_items.create(invoice_id: invoice2.id, quantity: 2, unit_price: item2.unit_price)

    get "/api/v1/invoice_items/#{ii1.id}.json"
    result = JSON.parse(response.body)

    expect(result["item_id"]).to eq(item1.id)
    expect(result["invoice_id"]).to eq(invoice1.id)
    expect(result["quantity"]).to eq(3)
    expect(result["unit_price"]).to eq(item1.unit_price.to_s)

  end

  it "finds a specific item invoice by id" do
    m1 = Merchant.create(name: "merchant 1")
    m2 = Merchant.create(name: "merchant 2")
    item1 = m1.items.create(name: "item name", description: "item description", unit_price: 10.00)
    item2 = m1.items.create(name: "item 2 name", description: "item 2 description", unit_price: 20.00)
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    invoice1 = customer.invoices.create(merchant_id: m1.id, status: "shipped")
    invoice2 = customer.invoices.create(merchant_id: m2.id, status: "shipped")
    customer2.invoices.create(merchant_id: m1.id, status: "shipped")
    customer.invoices.create(merchant_id: m2.id, status: "shipped")
    ii1 = item1.invoice_items.create(invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price)
    item2.invoice_items.create(invoice_id: invoice2.id, quantity: 2, unit_price: item2.unit_price)

    get "/api/v1/invoice_items/find?id=#{ii1.id}"
    result = JSON.parse(response.body)

    expect(result["item_id"]).to eq(item1.id)
    expect(result["invoice_id"]).to eq(invoice1.id)
    expect(result["quantity"]).to eq(3)
    expect(result["unit_price"]).to eq(item1.unit_price.to_s)
  end
end
