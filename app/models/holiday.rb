# frozen_string_literal: true

class Holiday < ApplicationRecord
  validates :date, presence: { message: 'Invalid date' }
  validates :name, presence: true, uniqueness: true,
                   format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: 'should not contain numbers' }
end
