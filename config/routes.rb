Rails.application.routes.draw do
  resources :hr
  resources :employees
  resources :events
  resources :holidays
  resources :leave_requests
  resources :salaries
  
  patch 'approve/:id', to: 'leave_requests#approve_request'
  patch 'reject/:id', to: 'leave_requests#reject_request'
  put '/leave_requests/update', to: 'leave_requests#update'
  delete '/leave_requests/delete', to: 'leave_requests#delete'

  get 'all_employees', to: 'hr#index'
  post 'hr/create', to: 'hr#create'
  get 'hr/destroy'
  post 'hr/login'

  post 'employee/login', to: 'employees#login'
  get 'employee/update', to: 'employees#update'

  get '/holidays', to: 'holidays#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
