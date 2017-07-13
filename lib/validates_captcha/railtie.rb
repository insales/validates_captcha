module ValidatesCaptcha
  class Railtie < Rails::Railtie
    initializer 'validates_captcha.configure' do |app|
      app.middleware.use ::ValidatesCaptcha::MiddlewareWrapper
    end

    config.after_initialize do
      ::ActiveRecord::Base.send :include, ValidatesCaptcha::ModelValidation
      ::ActionController::Base.send :include, ValidatesCaptcha::ControllerValidation
      ::ActionView::Base.send :include, ValidatesCaptcha::FormHelper
      ::ActionView::Helpers::FormBuilder.send :include, ValidatesCaptcha::FormBuilder
    end

    rake_tasks do
      load "tasks/static_image_tasks.rake"
    end
  end
end
