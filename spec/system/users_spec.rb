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

      it '認証メールの送信メッセージが表示される' do
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end

      # it 'Userモデルにレコードが1つ追加されるか' do
      #   expect(User).to change(User, :count).by(1)
      # end

      it 'ページが遷移されていること' do
        expect(page).to have_content 'Futher Effortsとは？'
      end
    end

    context '全てが正しく入力されていない時' do
      before do
        visit new_user_registration_path
        fill_in "name", with: ''
        fill_in "email", with: 'test@example.com'
        fill_in "password", with: 'password'
        fill_in "password_confirmation", with: 'password'
        click_button 'commit'
      end

      it '認証メールが送信されずにエラーメッセージが表示される' do
        expect(page).to have_content 'エラーが発生したため ユーザ は保存されませんでした。'
      end

      it 'ページが遷移されないこと' do
        expect(page).to_not have_content 'Futher Effortsとは？'
      end
    end
  end

  describe 'ランキングページ' do
    context 'ログインしているとき' do
      before do
        user_a.confirm
        sign_in(user_a)
        visit users_ranking_path
      end

      it 'ランキングページが表示される' do
        expect(page).to have_content '週間ランキング'
      end
    end

    context 'ログインしていない時' do
      before do
        visit users_ranking_path
      end

      it '一覧表示機能が表示されない' do
        expect(page).not_to have_content 'みんなの努力の掲示板'
      end

      it 'ログインリンクに飛ばされる' do
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      user_a.confirm
    end
    context '全てが正しく入力されている場合' do
      before do
        visit new_user_session_path
        fill_in "email", with: 'test01@example.com'
        fill_in "password", with: 'password'
        click_button 'commit'
      end

      it 'ログインができたフラッシュメッセージが表示されること' do
        expect(page).to have_content 'ログインしました'
      end

      it '投稿一覧ページに画面が遷移されていること' do
        expect(page).to have_content 'みんなの努力の掲示板'
      end
    end

    context '全てが正しく入力されていない場合' do
      before do
        visit new_user_session_path
        fill_in "email", with: 'test01@example.com'
        fill_in "password", with: ''
        click_button 'commit'
      end

      it 'エラーメッセージが表示されること' do
        expect(page).to_not have_content 'ログインしました'
        expect(page).to have_content 'パスワードが違います'
      end

      it '投稿一覧ページに画面が遷移されないこと' do
        expect(page).to_not have_content 'みんなの努力の掲示板'
      end
    end
  end

  describe '編集機能' do
    before do
      user_a.confirm
      user_b.confirm
    end
    context '同じユーザーでログインしている' do
      before do
        sign_in(user_a)
        visit edit_user_registration_path
      end

      it '編集ページが表示できること' do
        expect(page).to have_content '本人確認のため、現在のパスワードを入力してください'
      end

      it '編集が適用されること' do
        fill_in "name", with: 'edited_name'
        fill_in "current_password", with: 'password'
        click_button 'commit'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context 'ログインしていない場合' do
      before do
        visit edit_user_registration_path
      end

      it '編集ページに飛べないこと' do
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end