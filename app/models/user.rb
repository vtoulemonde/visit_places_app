class User < ActiveRecord::Base
	has_secure_password
	validates :username, presence: true
	has_many :visits

	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	mount_uploader :picture, PictureUploader
	
	has_many :recommendations

	def get_friends
		friends = []
		friendships.each do |friendship|
			friends << friendship.friend
		end
		friends
	end

end
