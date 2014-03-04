RailsCanvas::Application.routes.draw do

  get "home/index"
  get "home/salesforce", as: :salesforce
  match "canvas" => "canvas#index", :via => :post

  root 'home#index'
end
