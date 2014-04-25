class Band < ActiveRecord::Base
	validates :band_name, presensce: true
	validates :band_name, uniqueness: true

	has_many(
		:albums,
		class_name: "Album",
		foreign_key: :album_id,
		primary_key: :id,
		dependent: :destroy
	)

	has_many(
		:tracks,
		class_name: "Track",
		foreign_key: :track_id,
		primary_key: :id,
		dependent: :destroy
	)

	has_many(
		:tracks,
		through: :albums,
		source: :tracks
	)

end
