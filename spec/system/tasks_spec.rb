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
        fill_in '開始日', with: Time.parse("2021/05/20 19:00:00")
        fill_in '終了日', with: Time.parse("2021/05/20 19:00:00")
        check '終日'
        fill_in 'スケジュールメモ', with: 'テストテスト'
        click_on 'スケジュールを新規登録する'
        visit tasks_path
      end
      it '追加したスケジュールが表示される' do
        expect(page).to have_content 'テスト'
      end
    end
  end
end