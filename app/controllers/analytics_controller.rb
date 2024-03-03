class AnalyticsController < ApplicationController
    def index
        @activity_counts_by_type = Activity.joins(:activity_type).group('activity_types.id').count

        @activity_counts_by_type2 = MemberActivity.joins(activity: :activity_type)
                                          .group('activity_types.id')
                                          .count

 
    
    end
  end
  