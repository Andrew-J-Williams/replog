class User < ActiveRecord::Base
    has_many :customers
    has_secure_password

    validates :username, :email, :password, presence: true
    validates :username, :email, uniqueness: true
end