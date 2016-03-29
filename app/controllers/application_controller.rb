class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # Actions require the user to be logged in
  before_action :require_login
  
	def require_login
		unless logged_in?
			flash[:danger] = "You must be logged in to access this section"
			redirect_to login_url
		end
	end
end
