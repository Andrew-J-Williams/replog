class UsersController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id
            redirect to "/customers"
        elsif params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:message] = "INVALID SIGN UP. Please leave no fields blank."
            redirect to '/signup'
        else
            flash[:message] = "Account already exists for username or email. Please log in."
            redirect to '/login'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/customers'
          else
            flash[:message] = "Sorry, invalid log in! Please try again."
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/'
        else
            redirect to '/'
        end
    end

end