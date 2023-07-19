ActiveAdmin.register Employee do
  permit_params :name, :email, :password, :role, :joining_date, :salary, :balance

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :password
    column :role
    column :joining_date
    column :salary
    column :balance
    actions
  end

  filter :email
  filter :name
  filter :salary
  filter :joining_date

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
      f.input :role
      f.input :joining_date
      f.input :salary
      f.input :balance
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :role, :joining_date, :salary, :balance]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
