module Api
  module V1
    class ItemsController < ApiController
      respond_to :json

      def index
        respond_with Item.all
      end
    end
  end
end
