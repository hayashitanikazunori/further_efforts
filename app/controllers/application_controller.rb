class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # ユーザー登録と編集フォームで受け取ったユーザー名をDBに保存するストロングパラメータ
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:accoount_update, keys: [:name])
    end
end
