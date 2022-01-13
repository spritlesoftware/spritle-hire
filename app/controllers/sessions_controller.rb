class SessionsController < Devise::SessionsController
	def create
		super do |resource|
			unless !resource.took_test?
				sign_out
				flash[:notice] = "Already you have completed this test"
				redirect_to new_user_session_path
				return
			end
		end
	end

	def destroy
		super do |resource|
			redirect_to new_user_session_path
			return
		end
	end
end
