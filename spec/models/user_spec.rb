require 'rails_helper'
# factory_botなしの場合
# describe User do
#   describe '#create' do
#     it "is invalid without a nickname" do
#       user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
#       user.valid?
#       expect(user.errors[:nickname]).to include("can't be blank")
#     end
#     it "is invalid without a email" do
#       user = User.new(nickname: "sawaki", email: "", password: "00000000", password_confirmation: "00000000")
#       user.valid?
#       expect(user.errors[:email]).to include("can't be blank")
#     end
#   end
# end

# factory_botありの場合
# describe User do
#   describe '#create' do
#     it "is invalid without a nickname" do
#       user = build(:user, nickname: "")
#       user.valid?
#       expect(user.errors[:nickname]).to include("can't be blank")
#     end
#     it "is invalid without a email" do
#       user = build(:user, email: "")
#       user.valid?
#       expect(user.errors[:email]).to include("can't be blank")
#     end
#   end
# end

# 新規ユーザー登録時のテストコード
describe User do
  describe '#create' do
    it "can register if nickname and email, password and password_confirmation exist" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation if password exists" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "Cannot register if nickname is 7 characters or more" do
      user = build(:user, nickname: "abeabea")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "Can register if nickname is 6 characters or less" do
      user = build(:user, nickname: "abeabe")
      expect(user).to be_valid
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      next_user = build(:user)
      next_user.valid?
      expect(next_user.errors[:email]).to include("has already been taken")
    end

    it "Can be registered if password is 6 characters or more" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user.valid?).to eq true
    end

    it "Cannot register if password is 5 characters or less" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end