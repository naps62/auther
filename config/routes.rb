Rails.application.routes.draw do
  get "/auth/:provider/callback" => "auther/sessions#create_from_omniauth"
end
