# frozen_string_literal: true

class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :role, :salary, :balance, :image

  def image
    object.image.url
  end
end
