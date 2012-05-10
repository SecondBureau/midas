require 'digest/md5'

class User < ActiveRecord::Base
	attr_accessible :email, :password

	# test : 098f6bcd4621d373cade4e832627b4f6
	def self.auth?(email, password)
		hashed_password = Digest::MD5.hexdigest(password)
		user = User.find(:first, :conditions => "email='#{email}' and password='#{hashed_password}'" )
		return !user.nil?
	end
end
