# frozen_string_literal: true

class Employee < ApplicationRecord
  has_many :leave_requests, dependent: :destroy
  has_one_attached :image
  validates :name, :email, :password, :salary, :role, presence: true
  validates :joining_date, presence: { message: 'Invalid date' }
  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
                             message: 'should be in characters only' }

  validates :password, length: { in: 8..15, message: 'must be between 8 to 15 characters' }

  validates :email, uniqueness: { message: 'is already exist' },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: '%<value>s not a valid email !!!' },
                    exclusion: { in: %w[hr@gmail.com],
                                 message: '%<value>s is reserved.' }
  validate :validate_date

  def validate_date
  format_ok = string.match(/\d{4}-\d{2}-\d{2}/)
  parseable = Date.strptime(string, '%Y-%m-%d') rescue false

  if string == 'never' || format_ok && parseable
    puts "date is valid"
  else
    puts "date is not valid"
  end
end
end
