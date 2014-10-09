class Place < ActiveRecord::Base
	has_many :visits

	mount_uploader :picture, PictureUploader

	validates :name, :address, presence: true

end
