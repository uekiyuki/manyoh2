require 'rails_helper'

# RSpec.describe Task, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe 'タスク管理機能', type: :model do

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト2', content: '')
    expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end

  it "検索ロジック" do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:task, status: "未着手")
    FactoryBot.create(:second_task, status: "未着手")
    expect_task = FactoryBot.create(:third_task, status: "完了")
    result = Task.search(title_key: "タイトル3", status_key: "完了")
    # binding.irb
    expect(result[0].id).to be expect_task.id
    expect(result.size).to eq 1
  end
end

# バリデーションにmodelのテストを追加してみましょう。
# 検索ロジックのmodelのテストを追加してみましょう。