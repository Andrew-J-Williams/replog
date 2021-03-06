class CustomersController < ApplicationController

    get '/customers' do
        if logged_in?
            @customers = current_user.customers.order(:name) #Using 'order' will display the defined parameter in ascending order by default
            erb :'customers/index'
        else
            redirect to '/signup'
        end
    end
    
    get '/customers/new' do 
        if logged_in?
            erb :"/customers/new" #Renders a file (erb)
        else
            redirect to '/login' #Sends a HTTP request (redirect)
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
            if @customer.save
                redirect to '/customers'
            else
                flash[:message] = "Customer already exists or entry is invalid. Please try again."
                redirect to '/customers/new'
            end
        else
            redirect to '/login'
        end
    end

    get '/customers/:id/edit' do
        if logged_in?
            @customer = Customer.find_by(:id => params[:id])
            if current_user.id == @customer.user_id
                erb :"customers/edit"
            else
                flash[:message] = "ERROR. Customer belongs to a different user."
                redirect to '/customers'
            end
        end
    end

    patch '/customers/:id' do
        if logged_in?
          @customer = Customer.find_by(:id => params[:id])
          @customer.name = params[:name]
          @customer.address = params[:address]
          @customer.phone = params[:phone]
          @customer.date_created = params[:date_created]
          @customer.note = params[:note]
          if @customer.save
            redirect to "/customers/#{@customer.id}"
          else
            flash[:message] = "ERROR. Your changes could not be saved."
            redirect to "/customers/#{@customer.id}/edit"
          end
        else
            redirect to '/'
        end
    end

    delete '/customers/:id/delete' do
        if logged_in?
          @customer = Customer.find_by(:id => params[:id])
          if current_user.id == @customer.user_id
            @customer.delete
            redirect to '/customers'
          else
            redirect to '/login'
          end
        end
    end

end