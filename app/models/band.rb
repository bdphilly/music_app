class Band < ActiveRecord::Base
	validates :band_name, presence: true
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
		through: :albums,
		source: :tracks,
	)

end
