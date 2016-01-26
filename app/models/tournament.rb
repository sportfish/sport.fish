class Tournament < ActiveRecord::Base
	resourcify
	
 	belongs_to :user
end
