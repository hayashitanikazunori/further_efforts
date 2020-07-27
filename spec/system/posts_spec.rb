require 'rails_helper'

RSpec.describe '投稿機能', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  # user_a.confirm
  # user_b.confirm
  let(:post) { FactoryBot.create(:post, kind: 'JavaScript', body: 'test', span: '100', user_id: user_a.id) }
  describe '一覧表示機能' do
    context 'ログインしている時' do
      before do
        user_a.confirm
        sign_in(user_a)
        visit posts_path
      end
      it '投稿一覧のタイトルが表示される' do
        expect(page).to have_content 'みんなの努力の掲示板'
      end
    end

    context 'ログインしていない時' do
      before do
        visit posts_path
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

  describe '新規投稿機能' do
    context 'ログインして値が全て正しく入力されたとき' do
      before do
        user_a.confirm
        sign_in(user_a)
        visit new_post_path
      end
      
      it '投稿ができる' do
        select 'JavaScript', from: 'post[kind]'
        fill_in "body", with: 'body'
        select '01', from: 'time[post_span(4i)]'
        select '00', from: 'time[post_span(5i)]'
        click_button 'commit'
        expect(post).to be_valid 
        expect(page).to have_content '投稿しました'
      end
    end
    
    context 'ログインしていて値が全て正しく入力されていないとき' do
      before do
        user_a.confirm
        sign_in(user_a)
        visit new_post_path
      end
      
      it '投稿が失敗する' do
        select 'JavaScript', from: 'post[kind]'
        fill_in "body", with: nil
        select '01', from: 'time[post_span(4i)]'
        select '00', from: 'time[post_span(5i)]'
        click_button 'commit'
        expect(page).to have_content '投稿に失敗しました'
      end
    end

    context 'ログインしていないとき' do
      before do
        visit new_post_path
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
end