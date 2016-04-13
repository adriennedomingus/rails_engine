require "rails_helper"

RSpec.describe Customer, type: :model do
  it { should have_many :invoices }
  it { should have_many :transactions }
  it { should have_many :invoice_items }
  it { should have_many :merchants }

  it "returns favorite merchant" do
    create_transactions
    expect(Customer.first.favorite_merchant).to eq(Merchant.first)
  end
end
