module Api
  module V1
    class Items::RevenueController < ApplicationController
      respond_to :json

      def index
        respond_with Item.ranked_by_revenue.take(params[:quantity].to_i)
      end
    end
  end
end
