require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user1 = FactoryBot.create(:user)
  end
# バリデーションにmodelのテストを追加してみましょう。
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', user_id: @user1.id)
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト2', content: '', user_id: @user1.id)
    expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', content: '成功テスト', user_id: @user1.id)
    expect(task).to be_valid
  end

  context "modelに記載したscopeのをテスト" do
    before  do
      FactoryBot.create(:task, user_id: @user1.id)
      FactoryBot.create(:second_task, user_id: @user1.id)
      FactoryBot.create(:third_task, user_id: @user1.id)
    end
# 検索ロジックのmodelのテストを追加してみましょう。
  it "scope: serchで絞り込みのテスト" do
    #絞り込んだら、完了となっているタスクが１つ表示される。
    result = Task.search(title_key: "タイトル3")
    expect(result.size).to eq 1
  end

  it "scope: latest(作成日時の新しい順）でソートのテスト" do
    result = Task.latest
    expect(result[0].content).to eq 'コンテント3'
    expect(result[1].content).to eq 'コンテント2'
    expect(result[2].content).to eq 'コンテント1'
  end

  it "scope: expired(終了期限の近い）でソートのテスト" do
    result = Task.expired
    expect(result[0].content).to eq 'コンテント1'
    expect(result[1].content).to eq 'コンテント2'
    expect(result[2].content).to eq 'コンテント3'
  end

  it "scope: priority(優先度）でソートのテスト" do
    result = Task.priority
    expect(result[0].priority).to eq 'high'
    expect(result[1].priority).to eq 'medium'
    expect(result[2].priority).to eq 'low'
  end# it "scope: priority(優先度）でソートのテスト" do
  end
end


