module Api
  module V1
    class InvoicesController < ApiController
      respond_to :json

      def index
        respond_with Invoice.all
      end
    end
  end
end
