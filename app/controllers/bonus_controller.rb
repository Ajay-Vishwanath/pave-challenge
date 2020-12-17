class BonusController < ApplicationController
    def show
        @employees_with_role = Employee.where(:division => params[:id])

        if @employees_with_role.length > 0
        @top_3 = @employees_with_role.order('base_pay + equity + bonus DESC').limit(3)
        render :json => @top_3
        else
            render json: "No title/department/role with this name exists! Make sure spacing and capialization are correct"
        end
    end
end
