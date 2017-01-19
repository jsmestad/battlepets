Rails.application.configure do
  config.after_initialize do
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
  end
end
