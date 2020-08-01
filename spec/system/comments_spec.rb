require 'rails_helper'

RSpec.describe 'comments', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  let(:post) { FactoryBot.create(:post, kind: 'JavaScript', body: 'test', span: '100', user_id: user_a.id) }
  let(:comment) { FactoryBot.create(:comment, review: 'review', user_id: user_a.id, post_id: post.id) } 
  describe 'コメント新規投稿機能' do
    context 'ログインしているとき' do
      before do
        user_a.confirm
        sign_in(user_a)
        @post = post
        visit post_path(@post)
      end
      it 'コメントができる' do
        fill_in "comment_review", with: 'comment'
        expect {
          click_button 'commit'
          expect(page).to have_content 'comment'
        }.to change{ Comment.count }.by(1)
      end
    end

    context 'ログインしていないとき' do
      before do
        user_a.confirm
        @post = post
        visit post_path(@post)
      end
      it 'ログインページにとばされる' do
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'コメント削除機能' do
    context '新規投稿をしたユーザーの場合' do
      before do
        user_a.confirm
        @post = post
        @comment = comment
        sign_in(user_a)
        visit post_path(@post)
      end
      it 'コメントの削除ができる' do
        expect {
          page.accept_confirm do
            click_on 'comment_delete'
          end
          expect(page).to have_content 'コメントを削除しました。'  
        }.to change{ Comment.count }.by(-1)
      end
    end

    # context '別のユーザーの場合' do
    #   before do
    #     user_a.confirm
    #     user_b.confirm
    #     @post = post
    #     @comment = comment
    #     sign_in(user_b)
    #     visit post_path(@post)
    #   end
    #   it '削除ボタンが表示されない' do
    #     expect(page).to_not have_content ''
    #   end
    # end
  end
end