module Api
  module V1
    class Items::TopController < ApplicationController
      respond_to :json

      def index
        respond_with Item.ranked_by_number_sold.take(params[:quantity])
      end
    end
  end
end
