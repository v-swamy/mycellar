class User < ActiveRecord::Base

  has_many :wines

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 5}, allow_nil: true

  def total_bottles
    total = 0
    wines.each do |wine|
      total += wine.quantity
    end
    total
  end
end