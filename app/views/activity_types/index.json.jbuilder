# frozen_string_literal: true

json.array!(@activity_types, partial: 'activity_types/activity_type', as: :activity_type)
