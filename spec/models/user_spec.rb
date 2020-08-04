require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーを新規作成' do
    it '全てが入力されていれば有効に保存されるか' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'nameカラムが空の場合は無効になるか' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it 'avatarカラムが空でも有効に保存されるか' do
      user = FactoryBot.build(:user, avatar: nil)
      expect(user.save).to be_truthy
    end
  end
end
