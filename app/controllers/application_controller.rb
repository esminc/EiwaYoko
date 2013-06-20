class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :oauth2

  require 'google/api_client'
  def oauth2
    @client = Google::APIClient.new
    @client.authorization.client_id = ENV['YOKO_GOOGLE_ID']
    @client.authorization.client_secret = ENV['YOKO_GOOGLE_SECRET']
    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/calendar.readonly'
    @client.authorization.redirect_uri = oauth2callback_url
    @client.authorization.code = params[:code] if params[:code]
    if session[:token_id]
      token_pair = TokenPair.find(session[:token_id])
      @client.authorization.update_token!(token_pair.to_hash)
    end
    if @client.authorization.refresh_token && @client.authorization.expired?   
      @client.authorization.fetch_access_token!  
    end  
    unless @client.authorization.access_token || request.path_info =~ /^\/oauth2/        
      redirect_to oauth2authorize_url
    end
  end
end
