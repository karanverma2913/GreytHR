class Employee < ApplicationRecord
  has_many :leave_requests, dependent: :destroy
  has_one_attached :image
  validates :name, :email, :password, :salary, :role, presence: true
  validates :password, length: {  minimum: 8, maximum: 15, message: 'must be between 8 to 15 characters' }
  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
            message: 'should be in characters only' }
  validates :email, uniqueness: { message: 'is already exist' },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
            message: '%<value>s not a valid email !!!' },
            exclusion: { in: %w[hr@gmail.com],
            message: '%<value>s is reserved.' }

  def self.ransackable_attributes(auth_object = nil)
    ["balance", "created_at", "email", "id", "joining_date", "name", "password", "role", "salary", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "leave_requests"]
  end


  # after_save :is_save?
  # before_validation  :b_save?
  # def b_save?
  #   puts "Do You want to save it"
  # end
  # def is_save?
  #   puts "Data is saved successfully"
  # end
 end
