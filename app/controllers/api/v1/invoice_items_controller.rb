module Api
  module V1
    class InvoiceItemsController < ApiController
      respond_to :json

      def index
        respond_with InvoiceItem.all
      end
    end
  end
end
