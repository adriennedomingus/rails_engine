require "rails_helper"

RSpec.describe Merchant, type: :model do
  it { should have_many :items }
  it { should have_many :invoices }
  it { should have_many :transactions }
  it { should have_many :invoice_items }
  it { should have_many :customers }

  it "has ranks merchants by revenue" do
    create_transactions
    expect([Merchant.all[2], Merchant.all[1], Merchant.all[0]]).to eq(Merchant.ranked_by_revenue)
  end

  it "ranks merchants by items sold" do
    create_transactions
    expect([Merchant.all[2], Merchant.all[1], Merchant.all[0]]).to eq(Merchant.ranked_by_items_sold)
  end

  it "returns total revenue for a specific merchant" do
    create_transactions
    expect(Merchant.first.total_revenue[:revenue].to_f).to eq(6126.0)
  end

  it "returns number of items sold" do
    create_transactions
    expect(Merchant.first.items_sold).to eq(189)
  end
end
