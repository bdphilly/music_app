class Track < ActiveRecord::Base
	validates :track_name, :type_of_track, :band_id, :album_id, presence: true

	belongs_to(
		:album,
		class_name: "Album",
		foreign_key: :album_id,
		primary_key: :id
	)

	belongs_to(
		:band,
		class_name: "Band",
		foreign_key: :band_id,
		primary_key: :id
	)
end
