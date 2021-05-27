require 'rails_helper'

describe 'スケジュール管理機能', type: :system do
  describe 'スケジュール表示機能' do
    before do
      task_a = FactoryBot.create(:task)
      #task_a = FactoryBot.create(:task, title: 'task_a', start_at: Time.now, end_at: Time.now, all_day: true, memo: 'task_a memo')
    end
    context 'トップ画面で' do
      before do
        visit tasks_path
      end
      it 'スケジュールが表示される' do
        expect(page).to have_content 'test task'
      end
    end
  end

  describe 'スケジュール登録機能' do
    context '新規登録画面で' do
      before do
        visit new_task_path
        fill_in 'タイトル', with: 'テスト'
        fill_in '開始日', with: Time.parse('2021/05/20 19:00:00')
        fill_in '終了日', with: Time.parse('2021/05/20 19:00:00')
        check '終日'
        fill_in 'スケジュールメモ', with: 'テストテスト'
        click_on 'スケジュールを新規登録する'
      end
      it '追加したスケジュールが表示される' do
        expect(page).to have_content 'テスト'
        expect(page).to have_content 'スケジュールを登録しました'
      end
    end

    context '新規登録画面で' do
      before do
        visit new_task_path
        click_on 'スケジュールを新規登録する'
      end
      it '必須項目を入力するよう指示される' do
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '開始日を入力してください'
        expect(page).to have_content '終了日を入力してください'
        expect(page).to have_content 'スケジュールを登録できませんでした'
      end
    end

    context '新規登録画面で' do
      before do
        visit new_task_path
        fill_in 'タイトル', with: 'テスト'
        fill_in '開始日', with: Time.parse('2021/05/20 19:00:00')
        fill_in '終了日', with: Time.parse('2021/05/19 19:00:00')
        check '終日'
        fill_in 'スケジュールメモ', with: 'テストテスト'
        click_on 'スケジュールを新規登録する'
      end
      it '終了日を開始日より後にするよう指示される' do
        expect(page).to have_content '終了日は開始日より前にはできません'
        expect(page).to have_content 'スケジュールを登録できませんでした'
      end
    end
  end

  describe 'スケジュール更新機能' do
    before do
      task_a = FactoryBot.create(:task)
      visit tasks_path
    end
    context 'スケジュール更新画面で' do
      before do
        click_on '編集'
        fill_in 'タイトル', with: 'テスト'
        fill_in '開始日', with: Time.parse('2021/05/20 19:00:00')
        fill_in '終了日', with: Time.parse('2021/05/20 19:00:00')
        check '終日'
        fill_in 'スケジュールメモ', with: 'テストテスト'
        click_on 'スケジュールの編集を完了する'
      end
      it '更新したスケジュールが表示される' do
        expect(page).to have_content 'テスト'
        expect(page).to have_content 'スケジュールを更新しました'
      end
    end

    context 'スケジュール更新画面で' do
      before do
        click_on '編集'
        fill_in 'タイトル', with: ''
        fill_in '開始日', with: ''
        fill_in '終了日', with: ''
        click_on 'スケジュールの編集を完了する'
      end
      it '必須項目を入力するよう指示される' do
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '開始日を入力してください'
        expect(page).to have_content '終了日を入力してください'
        expect(page).to have_content 'スケジュールを更新できませんでした'
      end
    end

    context 'スケジュール更新画面で' do
      before do
        click_on '編集'
        fill_in '開始日', with: Time.parse('2021/05/20 19:00:00')
        fill_in '終了日', with: Time.parse('2021/05/19 19:00:00')
        click_on 'スケジュールの編集を完了する'
      end
      it '終了日を開始日より後にするよう指示される' do
        expect(page).to have_content '終了日は開始日より前にはできません'
        expect(page).to have_content 'スケジュールを更新できませんでした'
      end
    end
  end

  describe 'スケジュール削除機能' do
    before do
      task_a = FactoryBot.create(:task)
      visit tasks_path
    end
    context 'スケジュール削除機能で' do
      before do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
      end
      it 'スケジュールが削除される' do
        expect(page).not_to have_content 'テスト'
        expect(page).to have_content 'スケジュールを削除しました'
      end
    end
  end
end