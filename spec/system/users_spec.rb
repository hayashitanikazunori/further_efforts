require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  describe '新規登録機能' do
    context '全てが正しく入力されている時' do
      before do
        visit new_user_registration_path
        fill_in "name", with: 'tester'
        fill_in "email", with: 'test@example.com'
        fill_in "password", with: 'password'
        fill_in "password_confirmation", with: 'password'
        click_button 'commit'
      end

      it '登録完了のフラッシュメッセージが出る' do
        expect(page).to have_content 'アカウント登録が完了しました。'
      end

      it '画面が遷移される' do
        expect(response).to redirect_to('/posts/index')
      end
    end
  end
  # describe 'ログイン機能' do
  #   context '全てが正しく入力されている時' do
  #     # before do
        
  #     # end
  #     # エラーメッセージが起きてる
  #     it 'フラッシュメッセージが表示されるか' do
  #       sign_in(:user_a)
  #       expect(flash[:notice]).to be_present
  #     end

  #     it 'ページが遷移されるか' do
  #       expect(response).to redirect_to(posts_path)
  #     end
  #   end
  # end
end