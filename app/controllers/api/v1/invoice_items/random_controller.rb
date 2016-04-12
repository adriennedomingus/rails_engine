module Api
  module V1
    class InvoiceItems::RandomController < ApplicationController
      respond_to :json

      def show
        offset = rand(InvoiceItem.count)
        respond_with InvoiceItem.offset(offset).first
      end
    end
  end
end
