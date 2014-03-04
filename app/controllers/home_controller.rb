class HomeController < ApplicationController

  def index
    client = Restforce.new(
        oauth_token: session['signed_request']['client']['oauthToken'],
        instance_url: session['signed_request']['client']['instanceUrl']
      )  	
  	@contacts = client.query("select Id, Name from Contact Limit 10")
  end

end
