class Employee < ApplicationRecord
  has_many :leave_requests, dependent: :destroy
  has_one_attached :image
  validates :name, :email, :password, :salary, :role, presence: true
  validates :joining_date, presence: { message: 'Invalid date' }
  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
                             message: 'only letters are allowed in name' }

  validates :password, length: { in: 8..15, message: 'Password must be between 8 to 15 characters' }

  validates :email, uniqueness: { message: 'Email is already exist' },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: '%<value>s not a valid email !!!' },
                    exclusion: { in: %w[hr@gmail.com],
                                message: '%<value>s is reserved.' }
end
