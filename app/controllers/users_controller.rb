# frozen_string_literal: true

class UsersController < ApplicationController
     before_action :check_if_not_pleb
     before_action :set_user, only: %i[show edit update destroy]

     # GET /users or /users.json
     def index
          @users = User.all
          if params[:query].present?
               @users = User.where('first_name LIKE :query OR last_name LIKE :query OR email LIKE :query', query: "%#{params[:query]}%")
          end
          @my_user = User.find_by(email: session[':useremail'])
          if @my_user.check_platoon_leader
               if params[:query].present?
                    @users = User.where('(first_name LIKE :query OR last_name LIKE :query OR email LIKE :query) AND platoon_id = :platoon_id', query: "%#{params[:query]}%", platoon_id: @my_user.platoon_id)
               else
                    @users = User.where(platoon_id: @my_user.platoon_id)
               end
          end
     end

     # GET /users/1 or /users/1.json
     def show; end

     # GET /users/new
     def new
          @user = User.new
     end

     # GET /users/1/edit
     def edit; end

     # POST /users or /users.json
     def create
          @user = User.new(user_params_with_role)

          respond_to do |format|
               if @user.save
                    format.html { redirect_to(user_url(@user), notice: 'User was successfully created.') }
                    format.json { render(:show, status: :created, location: @user) }
               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json { render(json: @user.errors, status: :unprocessable_entity) }
               end
          end
     end

     # PATCH/PUT /users/1 or /users/1.json
     def update
          respond_to do |format|
               if @user.update(user_params_with_role)
                    format.html { redirect_to(user_url(@user), notice: 'User was successfully updated.') }
                    format.json { render(:show, status: :ok, location: @user) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json { render(json: @user.errors, status: :unprocessable_entity) }
               end
          end
     end

     # DELETE /users/1 or /users/1.json
     def destroy
          @user.destroy!

          respond_to do |format|
               format.html { redirect_to(users_url, notice: 'User was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

     private

     # Use callbacks to share common setup or constraints between actions.
     def set_user
          @user = User.find(params[:id])
          platoon = Platoon.find_by(id: @user.platoon_id)
          @platoon_name = 'Platoon name not available'
          @platoon_name = platoon.name if platoon
     end

     def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :platoon_id, :military_branch, :class_year)
     end

     def user_params_with_role
          permitted_params = user_params
          permitted_params[:role] = params[:user][:role] if user_can_change_role? && params[:user][:role].present? && user_can_change_role?

          permitted_params
     end

     def user_can_change_role?
          current_user = User.find_by(email: session[':useremail'])
          return true if current_user.check_admin

          user_to_update = User.find(params[:id])
          return true if current_user.check_platoon_leader && !user_to_update.check_admin

          false
     end

     def check_if_not_pleb
          current_user = User.find_by(email: session[':useremail'])
          redirect_to(root_path, alert: 'Not authorized') if current_user.nil? || !(current_user.check_admin || current_user.check_platoon_leader)
     end
end
