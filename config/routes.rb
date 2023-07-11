Rails.application.routes.draw do
  patch 'approve/:id', to: 'leave_requests#approve_request'
  patch 'reject/:id', to: 'leave_requests#reject_request'
  patch '/leave_request/update', to: 'leave_requests#update'
  delete '/leave_requests/delete', to: 'leave_requests#delete'
  get '/my_leave/requests', to: 'leave_requests#show'
  get '/leave_history', to: 'leave_requests#history'

  get 'employee/all', to: 'hr#index'
  post 'create/employee', to: 'hr#create'
  get 'destroy/employee/:id', to: 'hr#destroy'
  post 'hr/login', to: 'hr#login'

  post 'employee/login', to: 'employees#login'
  get 'employee/update', to: 'employees#update'

  get '/holidays', to: 'holidays#index'
  
  resources :hr
  resources :employees
  resources :events
  resources :holidays
  resources :leave_requests
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
