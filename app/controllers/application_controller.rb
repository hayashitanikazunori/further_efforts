class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
      posts_path
  end
  
  def after_sign_out_path_for(user)
    new_user_session_path
  end

  protected
  # ユーザー登録と編集フォームで受け取ったユーザー名をDBに保存するストロングパラメータ
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:accoount_update, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar])
    end
end
