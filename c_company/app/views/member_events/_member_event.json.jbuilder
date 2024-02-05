json.extract! member_event, :id, :user_id, :event_id, :date, :time_spent, :created_at, :updated_at
json.url member_event_url(member_event, format: :json)
