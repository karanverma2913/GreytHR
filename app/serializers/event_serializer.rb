# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :description
end
