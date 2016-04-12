module Api
  module V1
    class Customers::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:first_name]
          respond_with Customer.find_by("lower(first_name) = ?", params[:first_name].downcase)
        elsif params[:last_name]
          respond_with Customer.find_by("lower(last_name) = ?", params[:last_name].downcase)
        else
          respond_with Customer.find_by(param.to_sym => params[param])
        end
      end

      def index
        if params[:first_name]
          respond_with Customer.where("lower(first_name) = ?", params[:first_name].downcase)
        elsif params[:last_name]
          respond_with Customer.where("lower(last_name) = ?", params[:last_name].downcase)
        else
          respond_with Customer.where(param.to_sym => params[param])
        end
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
