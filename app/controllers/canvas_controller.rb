class CanvasController < ApplicationController

  # bypass request forgery protection for salesforce
  protect_from_forgery except: :index

  def index
    # store all of the signed request data returned
    # by salesforce in the current user's session
  	session[:signed_request] = Restforce.decode_signed_request(params[:signed_request], 
      ENV['CLIENT_SECRET'])

    redirect_to :root
  end
end
