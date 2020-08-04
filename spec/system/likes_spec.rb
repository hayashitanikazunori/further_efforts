require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  let(:post) { FactoryBot.create(:post, learning_language: 'JavaScript', memo: 'test', learned_time: '100', user_id: user_a.id) }
  let(:like) { FactoryBot.create(:like, post_id: post.id, user_id: user_b.id) }
  describe 'いいね登録機能' do
    context 'ユーザーがログインしているとき' do
      before do
        user_a.confirm
        user_b.confirm
        sign_in(user_b)
        @post = post
        visit post_path(@post)
        click_on 'like_create'
      end
      it 'いいねができるか' do
        expect(page).to have_content "いいね！済み"
      end
    end
  end

  describe 'いいね削除機能' do
    context 'ユーザーがログインしているとき' do
      let(:user_like) { like }
      let(:user_post) { post}
      before do
        user_a.confirm
        user_b.confirm
        sign_in(user_b)
        visit post_path(user_post)
        click_on 'like_create'
      end
      it 'いいねができるか' do
        click_on 'like_delete'
        expect(page).to have_content "いいね！"
      end
    end
  end
end