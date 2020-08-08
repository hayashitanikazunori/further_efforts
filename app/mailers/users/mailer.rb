class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  opts[:subject] = "【Futher Effots】会員登録完了"
  super
end