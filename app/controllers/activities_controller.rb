# frozen_string_literal: true

class ActivitiesController < ApplicationController
     before_action :set_activity, only: %i[show edit update destroy]
     before_action :check_if_not_pleb
     # GET /activities or /activities.json
     def index
          @activities = Activity.all
     end

     # GET /activities/1 or /activities/1.json
     def show; end

     # GET /activities/new
     def new
          @activity = Activity.new
     end

     # GET /activities/1/edit
     def edit; end

     # POST /activities or /activities.json
     def create
          @activity = Activity.new(activity_params)

          respond_to do |format|
               if @activity.save
                    format.html { redirect_to(@activity, notice: 'Activity was successfully created.') }
                    format.json { render(:show, status: :created, location: @activity) }

               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json { render(json: @activity.errors, status: :unprocessable_entity) }
               end
          end
     end

     # prepares variables for the page when it is rendered
     def assign_member
          # queries User table for all entries so the dropdown can be populated
          @users = User.all
          @activity = Activity.find(params[:activity_id])

          logger.info('works!!!!!!!!!!!!!!!!!!!!!')
          logger.info('here')
          logger.info('YOOOOOOOOOOOOOO')
          # prints nothing since no user_id is selected right when the page is rendered
          logger.info(params[:user_id])
     end

     # params generated in form(assign_member.html.erb) are passed to this function
     def another_function
          # printing params
          # logger.info('params hash below')
          # logger.info(params.inspect)

          # get user id from params
          user_id = params[:user_id]

          # logger.info(user_id)
          # logger.info(params[:activity_id])
          # logger.info("!!!!!!!!!!!!!!!!!!!")

          # get activity id
          @activity = Activity.find(params[:activity_id])

          # get deadline from params
          deadline = params[:deadline]

          # ensure user_id is present
          if user_id.present? && deadline.present?

               user = User.find(user_id)

               # prepares data for correlating row in MemberActivity
               member_activity = MemberActivity.new(
                    user_id: user.id,
                    activity_id: @activity.id,
                    date: Time.zone.today,
                    start_time: nil,
                    end_time: nil,
                    deadline: deadline
               )

               # saves the row to the MemberActivity table
               if member_activity.save
                    redirect_to(@activity, notice: 'Activity was successfully assigned to the member.')
               else
                    flash[:error] = 'Failed to assign activity to the member'
                    redirect_to(@activity)
               end

          # this else statement may not be needed
          else
               # Handle case where user_id or deadline are not present
               flash[:error] = 'User ID and deadline are required. Activity was not assigned'
               redirect_to(@activity)
          end
     end

     # prepares variables for the assigning to platoon page when it is rendered
     def assign_platoon
          # queries User table for all entries so the dropdown can be populated
          @platoon = Platoon.all
          @activity = Activity.find(params[:activity_id])

          logger.info('works!!!!!!!!!!!!!!!!!!!!!')
          logger.info('here')
          logger.info('YOOOOOOOOOOOOOO')
          # prints nothing since no user_id is selected right when the page is rendered
          logger.info(params[:platoon_id])
     end

     # params generated in form(assign_member.html.erb) are passed to this function
     def platoon_assignment
          logger.info('params hash below')
          logger.info(params.inspect)

          platoon_id = params[:platoon_id]

          logger.info(platoon_id)
          logger.info(params[:activity_id])
          logger.info('!!!!!!!!!!!!!!!!!!!')

          @activity = Activity.find(params[:activity_id])

          # Ensure platoon_id is present
          if platoon_id.present?
               platoon = Platoon.find(platoon_id)
               errors = []

               deadline = params[:deadline]

               platoon.users.each do |user|
                    member_activity = MemberActivity.new(
                         user_id: user.id,
                         activity_id: @activity.id,
                         date: Time.zone.today,
                         start_time: nil,
                         end_time: nil,
                         deadline: deadline
                    )

                    errors << 'Failed to assign activity to user' unless member_activity.save
               end

               if errors.empty?
                    redirect_to(@activity, notice: 'Activity was successfully assigned to all members in the platoon.')
               else
                    flash[:error] = errors.join('. ')
                    redirect_to(@activity)
               end

          else
               # Handle case where platoon_id is not present
               flash[:error] = 'Platoon ID is required'
               redirect_to(@activity)
          end
     end

     # PATCH/PUT /activities/1 or /activities/1.json
     def update
          respond_to do |format|
               if @activity.update(activity_params)
                    format.html { redirect_to(activity_url(@activity), notice: 'Activity was successfully updated.') }
                    format.json { render(:show, status: :ok, location: @activity) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json { render(json: @activity.errors, status: :unprocessable_entity) }
               end
          end
     end

     # DELETE /activities/1 or /activities/1.json
     def destroy
          @activity.destroy!

          respond_to do |format|
               format.html { redirect_to(activities_url, notice: 'Activity was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

     private

     # Use callbacks to share common setup or constraints between actions.
     def set_activity
          @activity = Activity.find(params[:id])
     end

     # Only allow a list of trusted parameters through.
     #  def activity_params
     #       params.require(:activity).permit(:name, :description, :activity_type_id, :activity_id, :user_id)
     #  end

     def activity_params
          params.require(:activity).permit(:name, :description, :activity_type_id)
     end

     def check_if_not_pleb
          current_user = User.find_by(email: session[':useremail'])
          redirect_to(root_path, alert: 'Not authorized') if current_user.nil? || !(current_user.check_admin || current_user.check_platoon_leader)
     end
end
