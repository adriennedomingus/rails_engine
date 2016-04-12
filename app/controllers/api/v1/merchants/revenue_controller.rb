module Api
  module V1
    class Merchants::RevenueController < ApplicationController
      respond_to :json

      def show
        if params[:date]
          respond_with Merchant.find(params[:id]).total_revenue_by_date(params[:date])
        else
          respond_with Merchant.find(params[:id]).total_revenue
        end
      end

      def index
        respond_with Merchant.ranked_by_revenue.take(params[:quantity].to_i)
      end
    end
  end
end
