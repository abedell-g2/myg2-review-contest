Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "campaigns#index"

  resources :campaigns, only: [:index] do
    collection do
      get  :select_strategy
      get  :step1
      get  :step2
      get  :step3
      post :create_campaign
    end
  end
end
