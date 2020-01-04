class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])

        # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    before_action :update_sign_in_at_periodically
    UPDATE_LOGIN_PERIOD = 10.hours

    protected

    def update_sign_in_at_periodically
        # use session cookie to avoid hammering the database
        if !session[:last_login_update_at] or session[:last_login_update_at] < UPDATE_LOGIN_PERIOD.ago
            session[:last_login_update_at] = Time.now
            if user_signed_in? and current_user.current_sign_in_at < 1.minute.ago # prevents double logins
                sign_in(current_user, :force => true)
            end
        end
    end
end
