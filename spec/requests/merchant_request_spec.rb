require 'rails_helper'

RSpec.describe "Merchant endpoint" do
  it "returns a hash of all merchants" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")
    m3 = Merchant.create(name: "merchant 3")
    Merchant.create(name: "merchant 4")

    get "/api/v1/merchants.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(4)
    expect(result.first["name"]).to eq(m1.name)
    expect(result[2]["id"]).to eq(m3.id)
  end

  it "returns a specific merchant" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")

    get "/api/v1/merchants/#{m1.id}.json"
    result = JSON.parse(response.body)

    expect(result["name"]).to eq(m1.name)
  end

  it "returns a random merchant" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")

    get "/api/v1/merchants/random.json"
    expect(response.status).to eq(200)
  end

  it "returns items associted with a merchant" do
    m1 = Merchant.create(name: "merchant 1")
    m2 = Merchant.create(name: "merchant 2")
    m1.items.create(name: "name", description: "description", unit_price: 10.88)
    m1.items.create(name: "other name", description: "other description", unit_price: 12.88)
    m2.items.create(name: "another name", description: "another description", unit_price: 14.88)

    get "/api/v1/merchants/#{m1.id}/items"
    result = JSON.parse(response.body)

    expect(result.count).to eq(2)
  end

  it "returns invoices associated with a merchant" do
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other name", last_name: "last name")
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the merchant")
    customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")

    get "/api/v1/merchants/#{merchant.id}/invoices"
    result = JSON.parse(response.body)

    expect(result.count).to eq(1)
  end
end
