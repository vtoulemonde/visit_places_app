class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :visit
end