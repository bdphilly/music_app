class Note < ActiveRecord::Base

	belongs_to(
		:album,
		:class_name => "Album",
		:foreign_key => :album_id,
		:primary_key => :id
	)

	belongs_to(
		:user,
		:class_name => "User",
		:foreign_key => :user_id,
		:primary_key => :id
	)



end
