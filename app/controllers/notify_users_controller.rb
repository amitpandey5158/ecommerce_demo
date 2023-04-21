class NotifyUsersController < ApplicationController

	def notify_users
		respond_to do |format|
			@notify_users = NotifyUser.find_or_create_by(product_id: params[:product_id], user_id: params[:user_id], notify: true)
		end
	end

end
