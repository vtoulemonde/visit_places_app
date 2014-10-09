class User < ActiveRecord::Base
	has_secure_password
	validates :username, :email, presence: true
	has_many :visits
	has_many :favorites

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

	def is_my_friend?(my_friend)
		friendships.each do |friendship|
			if friendship.friend_id == my_friend.id
				return true
			end
		end
		return false
	end

	def is_favorite?(the_place)
		favorites.each do |favorite|
			if favorite.place_id == the_place.id
				return true
			end
		end
		return false
	end

end
