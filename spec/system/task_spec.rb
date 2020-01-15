require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path 
        expect(page).to have_content 'タイトル1'
      end
    end
  end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task', content: 'new_task1' )
        visit tasks_path
        task_list = Task.all 
        expect(task_list[0].content).to eq 'コンテント1'
      end
    end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
      visit new_task_path
      fill_in "task[title]", with: "test_title1"
      fill_in "task[content]", with: "test_content1"
      click_on '登録する'
      expect(page).to have_content 'test_title1'
      expect(page).to have_content 'test_content1'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        @task1 = Task.create(title: "title01", content: "content01")
        visit task_path(@task1)
        expect(page).to have_content 'title01'
        expect(page).to have_content 'content01'
      end
    end
  end
# 終了期限のテストをsystem specで追記しましょう。
  describe "タスクが終了期限の降順に並んでいるかのテスト" do
    context '終了期限でソートするというボタンをクリックした場合' do
      it '終了期限が早い順に並び替えられたタスク一覧ページに遷移' do
    visit tasks_path
    click_on '終了期限でソートする'
    all('table td')[5].click_link '詳細'
    expect(page).to have_content '2020-01-01'
        end
    end
  end
# ステータスのテストをsystem specで追記しましょう。
  describe '優先度の高い順でソート' do
    context '優先度でソートするというボタンをクリックした場合' do
      it '優先度の降順に並び替えられたタスク一覧ページに遷移' do
        visit tasks_path
        click_on '優先度でソートする'
        sleep 1
        all('table td')[5].click_link '詳細'   
        expect(page).to have_content 'タイトル3'
      end 
    end
  end
  
  describe 'ステータスで検索' do
    context '作業中で検索するというボタンをクリックした場合' do
      it 'タスク一覧に作業中のタスクが表示される' do
        visit tasks_path
        select '作業中', from: 'status_key'        
        click_on '検索する'
        expect(page).to have_selector 'td', text: '作業中'
        expect(page).not_to have_selector 'td', text: '完了'
        expect(page).not_to have_selector 'td', text: '未着手'
      end
    end
  end
end
# save_and_open_page  
# byebug
