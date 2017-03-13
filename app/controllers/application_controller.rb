class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
  	head :not_found
  end
end
