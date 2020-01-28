require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    # FactoryBot.create(:label)
    # label_a = FactoryBot.create(:second_label)
    FactoryBot.create(:label)
    FactoryBot.create(:label2)
    user_a = FactoryBot.create(:user)
    user_b = FactoryBot.create(:second_user)
    FactoryBot.create(:task, user: user_a)
    FactoryBot.create(:second_task, user: user_a)
    task_c = FactoryBot.create(:third_task, user: user_a)
    # FactoryBot.create(:labelling, task: task_c)

    visit root_path
    fill_in "session_email", with: "test1@example.com"
    fill_in "session_password", with: "passwordpassword"
    click_button "ログイン"
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path 
        all('table td')[6].click_link '詳細'
        expect(page).to have_content 'タイトル1'
      end
    end
  end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
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
        visit tasks_path
    # binding.irb
        all('table td')[6].click_link '詳細'
        expect(page).to have_content 'タイトル1'
      end
    end
  end
# 終了期限のテストをsystem specで追記しましょう。
  describe "タスクが終了期限の降順に並んでいるかのテスト" do
    context '終了期限でソートするというボタンをクリックした場合' do
      it '終了期限が早い順に並び替えられたタスク一覧ページに遷移' do
    visit tasks_path
    click_on '終了期限でソートする'
    expect(page).to have_content 'タスク一覧'
    all('table td')[6].click_link '詳細'
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
        expect(page).to have_content 'タスク一覧'
        all('table td')[6].click_link '詳細'   
        expect(page).to have_content 'タイトル1'
      end 
    end
  end
  
  describe 'ステータスで検索' do
    context '作業中で検索するというボタンをクリックした場合' do
      it 'タスク一覧に作業中のタスクが表示される' do
        visit tasks_path
        select '作業中', from: 'status_key' 
        expect(page).to have_content '詳細'
        click_on '検索'
        expect(page).to have_selector 'td', text: '作業中'
        expect(page).not_to have_selector 'td', text: '完了'
        expect(page).not_to have_selector 'td', text: '未着手'
      end
    end
  end
  
  describe 'ラベル作成' do
    context '編集画面で、タスクにラベルを複数付けた時' do
      it '詳細画面で確認できる' do
        visit tasks_path
        all('table td')[7].click_link '編集'
        page.driver.browser.switch_to.alert.accept

        # byebug
        
        check ('task_label_ids_1')
        check ('task_label_ids_2')
        click_on '更新する'
        expect(page).to have_content 'sample１'
        expect(page).to have_content 'sample2'
      end
    end
  end

  describe 'ラベルで検索できる' do
    context '一覧画面で、ラベルを選択肢、検索を押すと' do
      it '該当ラベルを含むタスクが表示される' do
        visit tasks_path
        select('sample2', from: 'label_id')
        click_button '検索'
        expect(page).to have_content 'sample2'
      end
    end
  end 

end
# save_and_open_page  
# byebug