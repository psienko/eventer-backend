class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :name, :start_at, :end_at,
             :place, :status, :created_at, :updated_at,
             :errors, :error_messages

  def errors
    object.errors.messages if object.errors.present?
  end

  def error_messages
    object.errors.full_messages
  end
end
