class User < ActiveRecord::Base
	has_many :tasks

	has_secure_password

	# def password=(pw)
	# 	#  take pw and encrypt it

	# 	# put encrypted pw into our database in the password_digest column
	# end

	validates_presence_of :username, :email, :password 
end
