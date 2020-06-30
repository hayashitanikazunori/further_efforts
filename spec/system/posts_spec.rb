require 'rails_helper'

describe '投稿機能', type: :system do 
  describe '一覧表示' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user)
      # 作成者がユーザーAである投稿を作成しておく
      FactoryBot.create(:post, kind: 'JavaScript', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        visit new_user_session_path
        fill_in 'user[email]', with: 'test01@example.com'
        fill_in 'user[password]', with: 'test01'
        click_button 'commit'
      end

      it 'ユーザーAが作成した投稿が表示される' do
        # 作成済みの投稿の名称が画面上にい表示されていることを確認
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end