require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    # before do
    #   @order = Order.new(name: 'テスト太郎', email: 'test@example.com', telephone: '09012345678', delivery_address: '東京都銀座')
    # end
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

    subject { Order.new(params).valid? }

    it { is_expected.to eq true }

    context "名前が空の時" do
      let(:name) { '' }

      it {is_expected.to eq false}
    end

    context "メールアドレスが空の時" do
      let(:email) { '' }

      it {is_expected.to eq false}
    end

    context "メールアドレスの書式が正しくない(@がない)場合" do
      let(:email) { 'testexample.com' }

      it {is_expected.to eq false}
    end

    context "メールアドレスが全角の場合" do
      let(:email) { 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ' }

      it {is_expected.to eq true}
    end
    
    context "電話番号が空の時" do
      let(:telephone) { '' }

      it {is_expected.to eq false}
    end

    context "電話番号が全角の場合" do
      let(:telephone) { '０９０１２３４５６７８' }

      it {is_expected.to eq true}
    end

    context "電話番号に数字以外(ハイフン)が入力されていた場合" do
      let(:telephone) { '090-1234-5678' }

      it {is_expected.to eq true}
    end

    context "電話番号が12桁異常の場合" do
      let(:telephone) { '090123456789' }

      it {is_expected.to eq false}
    end

    context "お届け先住所が空の時" do
      let(:delivery_address) { '' }

      it {is_expected.to eq false}
    end    
  end
end
