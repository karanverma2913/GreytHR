ActiveAdmin.register LeaveRequest do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :start_date, :end_date, :leave_type, :reason, :status, :employee_id, :days
  #
  # or
  #
  # permit_params do
  #   permitted = [:start_date, :end_date, :leave_type, :reason, :status, :employee_id, :days]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
