require 'rails_helper'

RSpec.describe "Item endpoint" do
  it "returns a hash of all customers" do
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the other merchant")
    i1 = merchant.items.create(name: "item 1", description: "describing the item", unit_price: 1000)
    i2 = merchant.items.create(name: "item 2", description: "describing other the item", unit_price: 2000)
    i3 = merchant2.items.create(name: "item 3", description: "describing third the item", unit_price: 3000)

    get "/api/v1/items.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
    expect(result.first["name"]).to eq(i1["name"])
    expect(result[2]["description"]).to eq(i3.description)
    expect(result[1]["unit_price"]).to eq(i2.unit_price)
  end
end
