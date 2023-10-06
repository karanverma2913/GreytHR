
# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :admin_users, ActiveAdmin::Devise.config
  post 'hr/login', to: 'hr#login'

  post 'employee/login', to: 'employees#login'
  get 'employees', to: 'employees#index'
  put 'approve/:id', to: 'leave_requests#approve_request'
  put 'reject/:id', to: 'leave_requests#reject_request'
  get 'my_leave/requests', to: 'leave_requests#show'
  get 'all_leave_requests', to: 'leave_requests#index'
  resource :employee
  resources :events
  resources :holidays, except: [:destroy]
  resource :leave_requests
end
