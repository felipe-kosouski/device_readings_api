Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post "readings", to: "readings#create"
  get "latest_timestamp/:device_id", to: "readings#latest_timestamp"
  get "cumulative_count/:device_id", to: "readings#cumulative_count"
end
