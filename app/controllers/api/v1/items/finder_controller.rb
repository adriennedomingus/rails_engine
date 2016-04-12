module Api
  module V1
    class Items::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with Item.find(params[:id])
        elsif params[:name]
          respond_with Item.find_by(name: params[:name])
        elsif params[:description]
          respond_with Item.find_by(description: params[:description])
        elsif params[:merchant_id]
          respond_with Item.find_by(merchant_id: params[:merchant_id])
        elsif params[:unit_price]
          respond_with Item.find_by(unit_price: params[:unit_price])
        elsif params[:created_at]
          respond_with Item.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Item.find_by(created_at: params[:updated_at])
        end
      end

      def index
        if params[:id]
          respond_with Item.where(id: params[:id])
        elsif params[:name]
          respond_with Item.where(name: params[:name])
        elsif params[:description]
          respond_with Item.where(description: params[:description])
        elsif params[:merchant_id]
          respond_with Item.where(merchant_id: params[:merchant_id])
        elsif params[:unit_price]
          respond_with Item.where(unit_price: params[:unit_price])
        elsif params[:created_at]
          respond_with Item.where(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Item.where(created_at: params[:updated_at])
        end
      end
    end
  end
end
