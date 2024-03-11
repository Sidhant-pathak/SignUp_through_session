class ApplicationController < ActionController::Base
    before_action :current_user
    helper_method :current_user


    private 
     def require_login
        unless current_user
            
           redirect_to login_path, alert: 'Please Login!'
        end
    end

    
     
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
   end
end