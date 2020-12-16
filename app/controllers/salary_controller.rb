class SalaryController < ApplicationController
    def index
    end

    def show
        puts params
        @restaurant = Restaurant.find_by(name: params[:id])

        if @restaurant
            @salary = Employee.where(:restaurant_id => @restaurant.id).average(:base_pay)
            render :json => @salary
        else
            render json: "No restaurant with this name exists! Make sure capialization is correct"
        end
    end
end
