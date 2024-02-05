json.extract! member_activity, :id, :user_id, :activity_id, :date, :time_spent, :created_at, :updated_at
json.url member_activity_url(member_activity, format: :json)
