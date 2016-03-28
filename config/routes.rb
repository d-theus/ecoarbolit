Rails.application.routes.draw do
  resource :price, only: [:show], controller: :price
  resources :pros, only: [:index] do
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
    get :beneficial,      on: :collection
    get :absorbing,       on: :collection
    get :fireproof,       on: :collection
  end
  resources :articles, only: [:index] do
    get 'stroitelstvo-iz-blokov-nesjomnoy-opalubki-i-sverckhprochnogo-arbolita', action: :stroitelstvo_iz_blokov_nesjomnoy_opalubki_i_sverckhprochnogo_arbolita, on: :collection
  end
  root to: 'landing#show'
end
