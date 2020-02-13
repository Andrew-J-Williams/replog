class CustomersController < ApplicationController

    get '/customers' do
        if logged_in?
            @customers = current_user.customers
            erb :'customers/index'
        else
            redirect to '/signup'
        end
    end
    
    get '/customers/new' do 
        if logged_in?
            erb :"/customers/new"
        else
            redirect to '/login'
        end
    end

    get '/customers/:id' do
        if logged_in?
          @customer = Customer.find_by(:id => params[:id])
          erb :"customers/show"
        else
          redirect '/login'
        end
    end

    post '/customers' do
        if logged_in?
            @customer = current_user.customers.create(:name => params[:name], :address => params[:address], :phone => params[:phone], :date_created => params[:date_created], :note => params[:note])
            redirect "/customers"
        else
            erb '/customers/create'
        end
    end

    get '/customers/:id/edit' do
        if logged_in?
            @customer = Customer.find_by(:id => params[:id])
            if current_user.id == @customer.user_id
                erb :"customers/edit"
            else
                redirect to '/login'
            end
        end
    end

end