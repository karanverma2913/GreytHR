class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def valid_date
    return if date.blank?

    return unless date <= Date.today

    errors.add(:date, 'Enter Valid Date ')
  end
end
