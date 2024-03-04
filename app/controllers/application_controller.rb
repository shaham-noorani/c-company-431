# frozen_string_literal: true

class ApplicationController < ActionController::Base
     helper_method :current_user

     private

     def current_user
          # Use find_by to return nil instead of raising an exception if the user is not found
          @current_user ||= User.find_by(email: session[':useremail'])
     end
end
