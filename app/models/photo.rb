class Photo < ActiveRecord::Base
  belongs_to :visit

  mount_uploader :picture, PictureUploader
end
