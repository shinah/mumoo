class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)
 
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end
  
  [:facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end
  
  def after_sign_in_path_for(resource)
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    @user = User.find(current_user.id)
    #로그인 되어있으면 바로 메인 페이지 보여주고
    if @user.persisted?
      exhibition_main_path
    #로그인 안되어있으면 mumoo 소개 페이지를 보여준다.
    else
      exhibition_index_path
    end
  end  
end
