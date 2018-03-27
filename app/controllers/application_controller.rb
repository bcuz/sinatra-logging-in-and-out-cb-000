require_relative '../../config/environment'

require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    # binding.pry

    if !@user.nil?
      session[:user_id] = @user.id
      redirect '/account'

    else
      erb :error

    end

  end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    # binding.pry
    # not going straight the the page...

      # erb :account
      # binding.pry
    if !@user.nil?
      erb :account
      # @user = User.find(session[:id])

    else
      # thats what its asking for
      erb :error

    end

  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
