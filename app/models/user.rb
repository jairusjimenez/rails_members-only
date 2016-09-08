class User < ApplicationRecord
	has_many :posts

	before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i


	validates :name, presence: true, length: { maximum: 50 }

	validates :email, presence: true, length: { maximum: 50 },
																	 format: { with: VALID_EMAIL_REGEX },
																	 uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	def User.new_token
		Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
	end

	def create_remember_token
		self.remember_token = User.new_token
	end
end