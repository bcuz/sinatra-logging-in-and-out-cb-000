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
    @user = User.find_by(username: params[:username])


    # if !@user.nil?
      session[:user_id] = @user.id
      redirect '/account'

    # else
    #   erb :error
    #
    # end
  end

  get '/account' do
    # not going straight the the page...
      @user = User.find(session[:user_id])
      # binding.pry

      # erb :account
      # binding.pry
      erb :account
    # if !@user.nil?
    #   # @user = User.find(session[:id])
    #
    # else
    #   # thats what its asking for
    #   erb :error
    #
    # end

  end

  get '/logout' do

  end


end
