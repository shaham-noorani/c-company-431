class AnalyticsController < ApplicationController
    def index
        @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count

        @memberactivity_counts_by_type = MemberActivity.joins(activity: :activity_type)
                                          .group('activity_types.id')
                                          .count

        @memberactivity_completed_by_type = MemberActivity.joins(activity: :activity_type).where(completed: true).group('activity_types.id').count

        @memberactivity_counts_by_activity = MemberActivity.joins(:activity).group('activities.id').count

        @memberactivity_completed = MemberActivity.joins(:activity).where(completed: true).group('activities.id').count
 
        @member_activities = MemberActivity.includes(:activity, user: :platoon).all
    
    end
  end
  