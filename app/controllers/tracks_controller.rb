class TracksController < ApplicationController
	def index
		@tracks = Track.all
		render :index
	end

	def show
		@track = Track.find(params[:id])
		render :show
	end

	def new
		@track = Track.new(:band_id => params[:band_id], 
			:album_id => params[:album_id])
		render :new
	end

	def create
		@track = Track.new(track_params)
		@track.album_id = params[:album_id]
		@track.band_id = Album.find(params[:album_id]).band_id

		if @track.save
			redirect_to album_url(@track.album_id)
		else
			flash.now[:errors] = @track.errors.full_messages
			render :new
		end
	end

	def edit
		@track = Track.find(params[:id])
		render :edit
	end

	def update
		@track = Track.find(params[:id])
		if @track.update_attributes(track_params)
			redirect_to track_url(@track)
		else
			flash.now[:errors] = @track.errors.full_messages
			render :edit
		end
	end
	
	def destroy
		@track = Track.find(params[:id])
		unless @track.nil?
			@track.delete
			redirect_to tracks_url
		else
			flash.now[:errors] = @track.errors.full_messages
			render :new
		end
	end

	private
	def track_params
		params.require(:track).permit(:track_name, :type_of_track)
	end
end