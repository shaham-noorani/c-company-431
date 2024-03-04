# frozen_string_literal: true

json.array!(@member_activities, partial: 'member_activities/member_activity', as: :member_activity)
