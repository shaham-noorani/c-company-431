class AnalyticsController < ApplicationController
    def index
        @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count

        @memberactivity_counts_by_type = MemberActivity.joins(activity: :activity_type)
                                          .group('activity_types.id')
                                          .count

        @memberactivity_completed_by_type = MemberActivity.joins(activity: :activity_type).where(completed: true).group('activity_types.id').count

        @memberactivity_counts_by_activity = MemberActivity.joins(:activity).group('activities.id').count

        @memberactivity_completed = MemberActivity.joins(:activity).where(completed: true).group('activities.id').count
        
        @platoons = Platoon.all
    
    end

    def analytics_logs
        # Add your logic for the analytics_logs action here
        @member_activities = MemberActivity.includes(:activity, user: :platoon).order(date: :desc).all

        # Completed MemberActivities
        @completed_member_activities = MemberActivity.includes(:activity, user: :platoon).where(completed: true).order(date: :desc).all

        # Not completed MemberActivities
        @not_completed_member_activities = MemberActivity.includes(:activity, user: :platoon).where(completed: [false, nil]).order(date: :desc).all


        render 'analytics_logs'
    end

    def platoon_analytics
        # Fetch analytics data specific to the platoon with id params[:platoon_id]
        @platoon = Platoon.find(params[:platoon_id])
        
        # Additional logic to fetch and display analytics data for the platoon
        @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count
        
        @memberactivity_completed_by_type = MemberActivity.joins(activity: :activity_type).joins(:user).where(completed: true, users: { platoon_id: @platoon.id }).group('activity_types.id').count

        @memberactivity_counts_by_type = MemberActivity.joins(activity: :activity_type).joins(:user).where(users: { platoon_id: @platoon.id })
                                          .group('activity_types.id')
                                          .count
        
        @memberactivity_counts_by_activity = MemberActivity.joins(:activity)
                                                          .joins(:user)
                                                          .where(users: { platoon_id: @platoon.id })
                                                          .group('activities.id')
                                                          .count
        
        @memberactivity_completed = MemberActivity.joins(:activity)
                                                   .joins(:user)
                                                   .where(completed: true, users: { platoon_id: @platoon.id })
                                                   .group('activities.id')
                                                   .count
        
        render 'platoon_analytics'
    end
      
  end
  