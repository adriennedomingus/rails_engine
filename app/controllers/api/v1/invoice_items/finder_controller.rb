module Api
  module V1
    class InvoiceItems::FinderController < ApplicationController
      respond_to :json

      def show
        respond_with InvoiceItem.find_by(param.to_sym => params[param])
      end

      def index
        respond_with InvoiceItem.where(param.to_sym => params[param])
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
