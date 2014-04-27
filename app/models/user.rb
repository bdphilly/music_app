# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
	validates :email, :session_token, :presence => true, :uniqueness => true
	validates :password_digest, :presence => { :message => "Password can't be blank" }
	validates :password, length: { :minimum => 6, :allow_nil => true }
  # validates :password_digest, :presence => true
  
	before_validation :ensure_session_token

	def self.generate_session_token
		SecureRandom::urlsafe_base64(16)
	end

	def self.find_by_credentials(email, secret)
		user = User.find_by_email(email)
		user.try(:is_password?, secret) ? user : nil
	end

	def password
		@password
	end

	def password=(secret)
		@password = secret
		self.password_digest = BCrypt::Password.create(secret)
	end

	def is_password?(secret)
		BCrypt::Password.new(self.password_digest).is_password?(secret)
	end

	def reset_session_token!
		self.session_token = self.class.generate_session_token
		self.save!
		self.session_token
	end

	private
	def ensure_session_token
		self.session_token ||= self.class.generate_session_token
	end

end