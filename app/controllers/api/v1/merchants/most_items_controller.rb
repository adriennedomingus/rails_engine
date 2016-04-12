module Api
  module V1
    class Merchants::MostItemsController < ApplicationController
      respond_to :json

      def index
        respond_with Merchant.ranked_by_items_sold.take(params[:quantity].to_i)
      end
    end
  end
end
