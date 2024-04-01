# frozen_string_literal: true

class AnalyticsController < ApplicationController
     before_action :check_if_not_admin
     def index
          # Retrieve the filter parameter from the form
          filter_date = params[:startDate]
          Rails.logger.debug { "filter date: #{filter_date}" }

          filter_user = params[:user_id]

          user_id = nil

          if filter_user.present?

               name_and_email = filter_user.split(':')

               # Extract the last part which is the email
               email_u = name_and_email.last.strip

               # Extract the first part which contains last name and first name
               name_parts = name_and_email.first.split(',')

               # Extract the last name and first name
               last_name_u = name_parts.first.strip
               first_name_u = name_parts.last.strip

               user = User.find_by(first_name: first_name_u, last_name: last_name_u, email: email_u)

               if user.nil?
                    redirect_to(analytics_path(@platoon))
                    flash[:error] = 'Please select a valid user.'
                    Rails.logger.debug('User does not exist')
               else
                    Rails.logger.debug { "User found with ID: #{user.id}" }
                    user_id = user.id
               end
          end

          # Query and filter activity counts by type
          @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count

          # Query and filter completed member activities by type
          @memberactivity_completed_by_type = MemberActivity.joins(activity: :activity_type).where(completed: true)
          @memberactivity_completed_by_type = @memberactivity_completed_by_type.where(date: filter_date..) if filter_date.present?
          @memberactivity_completed_by_type = @memberactivity_completed_by_type.where(user_id: user_id) if user_id
          @memberactivity_completed_by_type = @memberactivity_completed_by_type.group('activity_types.id').count

          # Query and filter total member activities by type
          @memberactivity_counts_by_type = MemberActivity.joins(activity: :activity_type)
          @memberactivity_counts_by_type = @memberactivity_counts_by_type.where(date: filter_date..) if filter_date.present?
          @memberactivity_counts_by_type = @memberactivity_counts_by_type.where(user_id: user_id) if user_id
          @memberactivity_counts_by_type = @memberactivity_counts_by_type.group('activity_types.id').count

          # Query and filter member activities by activity
          @memberactivity_counts_by_activity = MemberActivity.joins(:activity)
          @memberactivity_counts_by_activity = @memberactivity_counts_by_activity.where(date: filter_date..) if filter_date.present?
          @memberactivity_counts_by_activity = @memberactivity_counts_by_activity.where(user_id: user_id) if user_id
          @memberactivity_counts_by_activity = @memberactivity_counts_by_activity.group('activities.id').count

          # Query and filter completed member activities by activity
          @memberactivity_completed = MemberActivity.joins(:activity).where(completed: true)
          @memberactivity_completed = @memberactivity_completed.where(date: filter_date..) if filter_date.present?
          @memberactivity_completed = @memberactivity_completed.where(user_id: user_id) if user_id
          @memberactivity_completed = @memberactivity_completed.group('activities.id').count

          @platoons = Platoon.all
     end

     def analytics_logs
          # Add your logic for the analytics_logs action here
          filter_date = params[:startDate]
          Rails.logger.debug { "filter date: #{filter_date}" }

          filter_user = params[:user_id]

          user_id = nil

          if filter_user.present?

               name_and_email = filter_user.split(':')

               # Extract the last part which is the email
               email_u = name_and_email.last.strip

               # Extract the first part which contains last name and first name
               name_parts = name_and_email.first.split(',')

               # Extract the last name and first name
               last_name_u = name_parts.first.strip
               first_name_u = name_parts.last.strip

               user = User.find_by(first_name: first_name_u, last_name: last_name_u, email: email_u)

               if user.nil?
                    redirect_to(analytics_logs_path(@platoon))
                    flash[:error] = 'Please select a valid user.'
                    Rails.logger.debug('User does not exist')
               else
                    Rails.logger.debug { "User found with ID: #{user.id}" }
                    user_id = user.id
               end
          end

          # Query member activities for all platoons
          @member_activities = MemberActivity.includes(:activity, user: :platoon)

          # Apply filter if a date is provided
          @member_activities = @member_activities.where('date >= ?', filter_date) if filter_date.present?

          # Apply filter if a user_id is provided
          @member_activities = @member_activities.where(user_id: user_id) if user_id.present?

          # Order member activities by date in descending order
          @member_activities = @member_activities.order(date: :desc)

          # Filter completed member activities
          @completed_member_activities = @member_activities.where(completed: true)

          # Filter not completed member activities
          @not_completed_member_activities = @member_activities.where('completed IS NULL OR completed = ?', false)
     end

     def platoon_analytics
          @platoons = Platoon.all

          @platoon = Platoon.find(params[:platoon_id])

          # Retrieve the filter parameter from the form
          filter_date = params[:startDate]

          # Query and filter activity counts by type
          @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count

          # Query and filter completed member activities by type
          @memberactivity_completed_by_type = MemberActivity.joins(activity: :activity_type)
                                                            .joins(:user)
                                                            .where(completed: true, users: { platoon_id: @platoon.id })
                                                            .where(date: filter_date..)
                                                            .group('activity_types.id')
                                                            .count

          # Query and filter total member activities by type
          @memberactivity_counts_by_type = MemberActivity.joins(activity: :activity_type)
                                                         .joins(:user)
                                                         .where(users: { platoon_id: @platoon.id })
                                                         .where(date: filter_date..)
                                                         .group('activity_types.id')
                                                         .count

          # Query and filter member activities by activity
          @memberactivity_counts_by_activity = MemberActivity.joins(:activity)
                                                             .joins(:user)
                                                             .where(users: { platoon_id: @platoon.id })
                                                             .where(date: filter_date..)
                                                             .group('activities.id')
                                                             .count

          # Query and filter completed member activities by activity
          @memberactivity_completed = MemberActivity.joins(:activity)
                                                    .joins(:user)
                                                    .where(completed: true, users: { platoon_id: @platoon.id })
                                                    .where(date: filter_date..)
                                                    .group('activities.id')
                                                    .count

          # Render the view
          render('platoon_analytics')
     end

     def platoon_logs
          @platoon = Platoon.find(params[:platoon_id])

          # Retrieve the filter parameter from the form
          filter_date = params[:startDate]

          # Query member activities based on platoon
          @member_activities = MemberActivity.includes(:activity, user: :platoon)
                                             .where(users: { platoon_id: @platoon.id })

          # Apply filter if a date is provided
          @member_activities = @member_activities.where('date >= ?', filter_date) if filter_date.present?

          # Order member activities by date in descending order
          @member_activities = @member_activities.order(date: :desc)

          # Filter completed member activities
          @completed_member_activities = @member_activities.where(completed: true)

          # Filter not completed member activities
          @not_completed_member_activities = @member_activities.where('completed IS NULL OR completed = ?', false)

          render('platoon_logs')
     end

     def check_if_not_admin
          redirect_to(root_path, alert: 'Not authorized') if current_user.nil? || !current_user.check_admin
     end
end
