require 'rails_helper'

  RSpec.describe User, type: :model do
    it "名前が空ならバリデーションが通らない" do
      user = User.new(name: '', email: 'a@example.com', password_digest: 'password')
      expect(user).not_to be_valid
    end
  
    it "メールアドレスが空ならバリデーションが通らない" do
      user = User.new(name: 'name', email: '', password_digest: 'password')
      expect(user).not_to be_valid
    end
  
    it "パスワードが空ならバリデーションが通らない" do
      user = User.new(name: 'name', email: 'a@example.com', password_digest: '')
      expect(user).not_to be_valid
    end
  
    it "titleとcontentに内容が記載されていればバリデーションが通る" do
      user = User.new(name: 'name', email: 'a@example.com', password_digest: 'password')
      expect(user).to be_valid
    end
  end

