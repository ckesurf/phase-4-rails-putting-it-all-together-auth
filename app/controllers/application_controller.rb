class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private 

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { errors: ["Not authorized"] }, status: :unauthorized
  end

end
