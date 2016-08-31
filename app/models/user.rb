class User < ActiveRecord::Base
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	
	has_secure_password

	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret


	validates :name, :email, :password, presence: true
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	before_save do
		self.email.downcase!
	end
end
