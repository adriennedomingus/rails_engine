module Api
  module V1
    class Items::InvoiceItemsController < ApplicationController
      respond_to :json

      def index
        respond_with Item.find(params[:id]).invoice_items
      end
    end
  end
end
