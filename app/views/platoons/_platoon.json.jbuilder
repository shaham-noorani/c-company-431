# frozen_string_literal: true

json.extract!(platoon, :id, :name, :leader_id, :created_at, :updated_at)
json.url(platoon_url(platoon, format: :json))
