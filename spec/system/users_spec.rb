require 'rails_helper'

describe 'ユーザー機能一覧', type: :system do 
  describe '新規登録機能テスト' do
    context '全てが正しく入力されている時' do
      it 'ページが遷移されるか' do
        visit new_user_registration_path
        user_a = FactoryBot.create(:user,
          name: 'ユーザーA',
          email: 'test01@example',
          password: 'password'
          # password_confirmation: 'password'
        )
        click_button '新規登録'
        expect(page).to have_content 'アカウント登録'
      end
    end
  end
end