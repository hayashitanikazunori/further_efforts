require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do 
  let(:user_a) { FactoryBot.create(:user, name: 'test01', email: 'test01@example.com', password: 'password', password_confirmation: "password") }
  let(:user_b) { FactoryBot.create(:user, name: 'test02', email: 'test02@example.com', password: 'password', password_confirmation: "password") }
  let(:following) { FactoryBot.create(:follow_relationship, follower_id: user_b.id, following_id: user_a.id) }
  describe 'フォロー全般機能' do
    context '別のユーザーがログインしている場合' do
      before do
        user_b.confirm
        sign_in(user_b)
        visit user_path(user_a)
      end

      it 'フォローができるか' do
        click_on 'follow_create'
        expect(page).to have_content 'フォローしました'
      end
    end

    context '別のユーザーがログインしていてすでにフォロー済みの場合' do
      let(:follow) { following }
      before do
        user_b.confirm
        sign_in(user_b)
        visit user_path(user_a)
        click_on 'follow_create'
      end
      it 'フォローを解除できるか' do
        click_on 'follow_delete'
        expect(page).to have_content 'フォローを解除しました'
      end
    end

    # context 'ユーザーが自身のshowページをみている場合' do
    #   before do
    #     user_a.confirm
    #     sign_in(user_a)
    #     visit user_path(user_a)
    #   end
    #   it 'フォローボタンが表示されない' do
    #     expect(page).to_not have_content 'フォローする。' ※この部分がおかしい
    #   end
    # end
  end
end