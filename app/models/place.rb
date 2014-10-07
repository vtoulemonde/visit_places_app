class Place < ActiveRecord::Base
	has_many :visits

	mount_uploader :picture, PictureUploader
end
