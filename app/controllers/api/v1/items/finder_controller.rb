module Api
  module V1
    class Items::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:name]
          respond_with Item.find_by("lower(name) = ?", params[:name].downcase)
        elsif params[:description]
          respond_with Item.find_by("lower(description) = ?", params[:description].downcase)
        else
          respond_with Item.find_by(param.to_sym => params[param])
        end
      end

      def index
        if params[:name]
          respond_with Item.where("lower(name) = ?", params[:name].downcase)
        elsif params[:description]
          respond_with Item.where("lower(description) = ?", params[:description].downcase)
        else
          respond_with Item.where(param.to_sym => params[param])
        end
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
