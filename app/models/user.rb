class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i } 
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy

  before_destroy do
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin?
  end

  before_update do
    throw(:abort) if User.where(admin: true).count <= 1
  end
end
