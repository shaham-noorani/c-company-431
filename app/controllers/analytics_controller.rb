class AnalyticsController < ApplicationController
    def index
      @activity_counts_by_type = Activity.joins(:activity_type)
                                         .group('activity_types.id')
                                         .count
    end
  end
  