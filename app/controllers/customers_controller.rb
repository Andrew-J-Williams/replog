class CustomersController < ApplicationController

    get '/customers'do
        if logged_in?
            @customers = current_user.customers
            erb :'customers/index'
        else
            redirect to '/signup'
        end
    end   

end