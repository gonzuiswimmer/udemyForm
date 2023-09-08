require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    # before do
    #   @order = Order.new(name: 'テスト太郎', email: 'test@example.com', telephone: '09012345678', delivery_address: '東京都銀座')
    # end
    let(:params) {
      {
        name: 'テスト太郎',
        email: 'test@example.com',
        telephone: '09012345678',
        delivery_address: '東京都銀座'
      }
    }

    it 'orderインスタンスがバリデーションを通過し、trueが返る' do
      order = Order.new(params)
      expect(order.valid?).to eq true
    end 
  end
end
