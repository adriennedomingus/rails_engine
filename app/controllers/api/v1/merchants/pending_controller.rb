module Api
  module V1
    class Merchants::PendingController < ApplicationController
      respond_to :json

      def index
        respond_with Merchant.find(params[:id]).customers_with_pending_invoices
      end
    end
  end
end
