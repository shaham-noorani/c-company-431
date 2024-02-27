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
    redirect_to(root_path)
    session[":useremail"] = user_info.info.email
  end
  def delete;end
  def destroy
    session.delete(":useremail")
    redirect_to root_path, notice: "You have been logged out."
  end
end
