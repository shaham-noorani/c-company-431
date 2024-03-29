# frozen_string_literal: true

json.extract!(activity, :id, :name, :activity_type_id, :description, :created_at, :updated_at)
json.url(activity_url(activity, format: :json))
