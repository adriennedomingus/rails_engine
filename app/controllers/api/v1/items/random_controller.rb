module Api
  module V1
    class Items::RandomController < ApplicationController
      respond_to :json

      def show
        offset = rand(Item.count)
        respond_with Item.offset(offset).first
      end
    end
  end
end
