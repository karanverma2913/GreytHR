# frozen_string_literal: true

Rails.application.routes.draw do
  post 'hr/login', to: 'hr#login'

  post 'employee/login', to: 'employees#login'
  get 'employees', to: 'employees#index'
  put 'approve/:id', to: 'leave_requests#approve_request'
  put 'reject/:id', to: 'leave_requests#reject_request'
  get 'my_leave/requests', to: 'leave_requests#show', as: 'karan'
  get 'all_leave_requests', to: 'leave_requests#index'
  resource :employee
  resources :events
  resources :holidays, except: [:destroy]
  resource :leave_requests
end
