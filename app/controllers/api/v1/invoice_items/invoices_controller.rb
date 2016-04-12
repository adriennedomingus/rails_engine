module Api
  module V1
    class InvoiceItems::InvoicesController < ApplicationController
      respond_to :json

      def show
        respond_with InvoiceItem.find(params[:id]).invoice
      end
    end
  end
end
