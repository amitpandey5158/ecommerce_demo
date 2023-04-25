class ProfilesController < ApplicationController
	
	def show
		@profile = Profile.find_by(id: params[:id])
	end
		
	def index
		@profile = current_user.profile
	end

	def update_profile
		profile = current_user.profile
		profile.update(profile_params)
		redirect_to profile_path(id:profile.id)
	end

	private

	def profile_params
		params.permit(:name, :contact_no, :address, :state, :city, :pincode, :image)
	end

end
