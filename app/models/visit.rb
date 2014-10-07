class Visit < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  has_many :recommendations
  has_many :photos
 
end
