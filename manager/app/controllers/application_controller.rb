class ApplicationController < ActionController::API
  rescue_from ActionController::UnpermittedParameters do |e|
    errors = params.collect do |param|
      {title: 'Param not allowed', detail: "#{param} is not allowed."}
    end
    render json: {errors: errors}, status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do |e|
    errors = params.collect do |param|
      {title: 'Missing Parameter', detail: "The required parameter, #{param}, is missing."}
    end
    render json: {errors: errors}, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    head :not_found
  end
end
