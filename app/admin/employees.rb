ActiveAdmin.register Employee do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :password, :role, :joining_date, :salary, :balance
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :role, :joining_date, :salary, :balance]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
