class Recommendation < ActiveRecord::Base
	belongs_to :user
  	belongs_to :visit

  	validates :comment, :user_id, presence: true

end
