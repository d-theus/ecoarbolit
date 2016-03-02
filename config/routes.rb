Rails.application.routes.draw do
  resources :pros, only: [] do
    get :level,           on: :collection
    get :insulating,      on: :collection
    get :solid,           on: :collection
    get :waterproof,      on: :collection
    get :eco,             on: :collection
    get :rot_free,        on: :collection
    get :crack_free,      on: :collection
    get :shrink_free,     on: :collection
    get :fastenable,      on: :collection
    get :simple,          on: :collection
    get :cuttable,        on: :collection
  end
  root to: 'landing#show'
end
