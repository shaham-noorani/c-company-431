class SessionsController < ApplicationController
  def new; end

  def create
    user_info = request.env['omniauth.auth']
    user = User.find_by(email: user_info.info.email)
    if user.nil?
      user = User.create!(
        first_name: user_info.info.first_name,
        last_name: user_info.info.last_name,
        email: user_info.info.email,
        role: 'pleb'
        
      )
    end
    redirect_to(users_path)
    session[":useremail"] = user_info.info.email
  end
end
