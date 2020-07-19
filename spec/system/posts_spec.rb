require 'rails_helper'

RSpec.describe '投稿機能', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  let(:post) { FactoryBot.create(:post, kind: 'JavaScript', body: 'test', span: '100', user_id: user_a.id) }
  describe '一覧表示機能' do
    context 'ログインしている時' do
      before do
        sign_in(user_a)
        visit posts_path
      end
      it '投稿一覧のタイトルが表示される' do
        expect(page).to have_content 'みんなの努力の掲示板'
      end
    end
    context 'ログインしていない時' do
      it '一覧表示機能が表示されない' do
        visit posts_path
        expect(page).not_to have_content 'みんなの努力の掲示板'
      end

      # it 'ログインリンクに飛ばされる' do
      #   visit posts_path
      #   expected.to redirect_to new_user_session_path
      # end
    end
  end
end