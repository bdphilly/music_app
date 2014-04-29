class NotesController < ApplicationController
	def create
		album = Album.find(params[:album_id])
		note = album.notes.new(note_params)
		# note.user_id = current_user.id

		note.save
		flash[:errors] = note.errors.full_messages
		redirect_to album_url(note.album_id)
	end

	def destroy
		note = Note.find(params[:id])
		note.destroy
		redirect_to album_url(note.album_id)
	end

	private

	def note_params
		params.require(:note).permit(:body, :user_id, :album_id)
	end

end
