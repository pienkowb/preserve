module RequestHelpers
  def json_response
    @json_response ||= begin
      JSON.parse(response.body).with_indifferent_access
    end
  end

  def reset_callbacks(controller)
    controller.reset_callbacks(:process_action)
    reset_callback_runners(controller) if Rails::VERSION::MAJOR == 3
  end

  def reset_callback_runners(controller)
    controller.class_eval do
      action_methods.each do |action_name|
        name = __callback_runner_name(action_name, :process_action)
        undef_method(name) if method_defined?(name)
      end
    end
  end
end
