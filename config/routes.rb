Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # mount API::Init, at: "/"
  mount API::InitDashboard, at: "/dashboard"
  mount GrapeSwaggerRails::Engine, as: "doc", at: "/doc"
end
