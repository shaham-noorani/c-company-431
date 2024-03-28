# frozen_string_literal: true

class MemberActivitiesController < ApplicationController
     before_action :set_member_activity, only: %i[show edit update destroy mark_complete]

     # GET /member_activities or /member_activities.json
     def index
          # Assuming you have a method to get the current user, like 'current_user'
          @member_activities = []
          my_user = User.find_by(email: session[':useremail'])
          unless my_user.nil?
               @member_activities = MemberActivity.where(user_id: my_user.id).includes(:activity)

               logger.info("this is #{@member_activities}")
          end
     end

     # GET /member_activities/1 or /member_activities/1.json
     def show; end

     # GET /member_activities/new
     def new
          @member_activity = MemberActivity.new
     end

     # GET /member_activities/1/edit
     def edit; end

     # POST /member_activities or /member_activities.json
     def create
          @member_activity = MemberActivity.new(member_activity_params)

          respond_to do |format|
               if @member_activity.save
                    format.html { redirect_to(member_activity_url(@member_activity), notice: 'Member activity was successfully created.') }
                    format.json { render(:show, status: :created, location: @member_activity) }
               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json { render(json: @member_activity.errors, status: :unprocessable_entity) }
               end
          end
     end

     # PATCH/PUT /member_activities/1 or /member_activities/1.json
     def update
          respond_to do |format|
               if @member_activity.update(member_activity_params)
                    format.html { redirect_to(member_activity_url(@member_activity), notice: 'Member activity was successfully updated.') }
                    format.json { render(:show, status: :ok, location: @member_activity) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json { render(json: @member_activity.errors, status: :unprocessable_entity) }
               end
          end
     end

     # DELETE /member_activities/1 or /member_activities/1.json
     def destroy
          @member_activity.destroy!
          respond_to do |format|
               format.html { redirect_to(member_activities_url, notice: 'Member activity was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

     # Custom action to mark an activity as completed
     # def mark_complete
     #   if @member_activity.update(completed: true)
     #     redirect_to member_activities_path, notice: 'Activity was successfully marked as completed.'
     #   else
     #     redirect_to member_activities_path, alert: 'Unable to mark activity as completed.'
     #   end
     # end

     def mark_complete
          if @member_activity.update(completed: true, start_time: Time.now - 60, end_time: Time.now)
               redirect_to(member_activities_path, notice: 'Activity was successfully marked as completed.')
          else
               redirect_to(member_activities_path, alert: 'Unable to mark activity as completed.')
          end
     end

     private

     # Use callbacks to share common setup or constraints between actions.
     def set_member_activity
          @member_activity = MemberActivity.find(params[:id])
     end

     # Only allow a list of trusted parameters through.
     def member_activity_params
          params.require(:member_activity).permit(:user_id, :activity_id, :date, :start_time, :end_time, :completed) # Ensure you include :completed if it's part of your form
     end
end
