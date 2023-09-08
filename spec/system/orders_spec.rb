require 'rails_helper'

RSpec.describe '注文フォーム', type: :system do
  let(:name) {'テスト太郎'}
  let(:email) {'test@example.com'}
  let(:telephone) {'09012345678'}
  let(:delivery_address) {'東京都銀座'}
  let(:params) {
    {
      name: name,
      email: email,
      telephone: telephone,
      delivery_address: delivery_address
    }
  }

  it '商品を注文できること' do
    visit new_order_path

    fill_in 'お名前', with: name
    fill_in 'メールアドレス', with: email
    fill_in '電話番号', with: telephone
    fill_in 'お届け先住所', with: delivery_address

    click_on '確認画面へ'

    expect(current_path).to eq confirm_orders_path
    
    click_on 'OK'

    expect(current_path).to eq complete_orders_path
    expect(page).to have_content "#{name}様"

    # 注文完了画面をリロードすると、新規注文画面に遷移する
    visit(complete_orders_path).to eq new_order_path

    order = Order.last
    expect(order.name).to eq name
    expect(order.email).to eq email
    expect(order.telephone).to eq telephone
    expect(order.delivery_address).to eq delivery_address
  end

  context 'フォームに不備がある場合' do
    it 'エラーメッセージが表示される' do
      visit new_order_path
  
      fill_in 'お名前', with: name
      fill_in 'メールアドレス', with: email
      fill_in '電話番号', with: '090123456789'
      fill_in 'お届け先住所', with: delivery_address
  
      click_on '確認画面へ'
  
      expect(current_path).to eq confirm_orders_path
      expect(page).to have_content '電話番号は11文字以内で入力してください'
    end
  end

  context '確認画面で戻るボタンをクリックした場合' do
    it '入力内容が保持されたまま新規注文画面に戻り、その後正常に商品を注文できる' do
      visit new_order_path
  
      fill_in 'お名前', with: name
      fill_in 'メールアドレス', with: email
      fill_in '電話番号', with: telephone
      fill_in 'お届け先住所', with: delivery_address
  
      click_on '確認画面へ'
  
      expect(current_path).to eq confirm_orders_path
      click_on '戻る'

      expect(current_path).to eq orders_path
      expect(page).to have_field 'お名前', with: name
      expect(page).to have_field 'メールアドレス', with: email
      expect(page).to have_field '電話番号', with: telephone
      expect(page).to have_field 'お届け先住所', with: delivery_address
      
      click_on '確認画面へ'
      expect(current_path).to eq confirm_orders_path

      click_on 'OK'
      expect(current_path).to eq complete_orders_path
      expect(page).to have_content "#{name}様"
  
      # 注文完了画面をリロードすると、新規注文画面に遷移する
      visit(complete_orders_path).to eq new_order_path
  
      order = Order.last
      expect(order.name).to eq name
      expect(order.email).to eq email
      expect(order.telephone).to eq telephone
      expect(order.delivery_address).to eq delivery_address
    end
  end


end
