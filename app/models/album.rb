class Album < ActiveRecord::Base
	validates :album_name, :band_id, :recording_type, presence: false

	has_many(
		:tracks,
		class_name: "Track",
		foreign_key: :track_id,
		primary_key: :id,
		dependent: :destroy
	)

	belongs_to(
		:band,
		class_name: "Band",
		foreign_key: :band_id,
		primary_key: :id
	)

end