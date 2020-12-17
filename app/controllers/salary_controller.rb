class SalaryController < ApplicationController
    def index
    end

    def show
        puts params
        @restaurant = Restaurant.find_by(name: params[:id])

        if @restaurant
            @salary = Employee.where(:restaurant_id => @restaurant.id).average(:base_pay).to_f
            render :json => @salary
        else
            render json: "No restaurant with this name exists! Make sure spacing and capialization are correct"
        end
    end
end
