class AlbumsController < ApplicationController

	def index
		if params[:band_id]
			band_albums_index
		else
			albums_index
		end
	end

	def albums_index
		@albums = Album.all
		render :albums_index
	end

	def band_albums_index
		@albums = Album.where(:band_id => params[:band_id])
		@band_id = params[:band_id]
		render :band_albums_index
	end

	def show
		@album = Album.find(params[:id])
		render :show
	end

	def new
		# @bands = Band.all
		@album = Album.new(:band_id => params[:band_id])
		render :new
	end

	def create
		@bands = Band.all
		@album = Album.new(album_params)
		if @album.save
			redirect_to album_url(@album)
		else
			flash.now[:errors] = @album.errors.full_messages
			render :new
		end
	end

	def edit
		@bands = Band.all
		@album = Album.find(params[:id])
		render :edit
	end

	def update
		@album = Album.find(params[:id])
		if @album.update_attributes(album_params)
			redirect_to album_url(@album)
		else
			flash.now[:errors] = @album.errors.full_messages
			render :edit
		end
	end
	
	def destroy
		@album = Album.find(params[:id])
		unless @album.nil?
			@album.destroy
			redirect_to albums_url
		else
			flash.now[:errors] = @album.errors.full_messages
			render :new
		end
	end

	private
	def album_params
		params.require(:album).permit(:album_name, :band_id, :recording_type)
	end
end
