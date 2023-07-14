# frozen_string_literal: true

Rails.application.routes.draw do
  post 'hr/login', to: 'hr#login'

  post 'employee/login', to: 'employees#login'
  get 'employees', to: 'employees#index'
  put 'approve/:id', to: 'leave_requests#approve_request'
  put 'reject/:id', to: 'leave_requests#reject_request'
  get 'my_leave/requests', to: 'leave_requests#history'

  resource :employee
  resources :events
  resources :holidays, except: [:destroy]
  resource :leave_request

end
