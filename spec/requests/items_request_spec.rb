require 'rails_helper'

RSpec.describe "Item  endpoint" do
  it "returns a hash of all items" do
    m1 = Merchant.create(name: "merchant 1")
    m2 = Merchant.create(name: "merchant 2")
    i1 = m1.items.create(name: "item name", description: "item description", unit_price: 1000)
    i2 = m1.items.create(name: "item 2 name", description: "item 2 description", unit_price: 2000)
    i3 = m2.items.create(name: "item 3 name", description: "item 3 description", unit_price: 3000)

    get "/api/v1/items.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
    expect(result.first["name"]).to eq(i1.name)
    expect(result[2]["description"]).to eq(i3.description)
    expect(result[1]["unit_price"]).to eq(i2.unit_price)
  end
end
