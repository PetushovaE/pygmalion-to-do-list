class User < ActiveRecord::Base
	has_many :tasks
	has_many :lists, :through => :tasks

	has_secure_password

	validates_presence_of :username, :email
end
