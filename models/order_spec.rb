require 'rails_helper'

RSpec.describe "発注機能", type: :model do
  let!(:user1){FactoryBot.create(:user)}
  let!(:user2){FactoryBot.create(:second_user)}
  let!(:item){FactoryBot.create(:item)}

  context "2人のユーザが同じ商品を同時に5個ずつ注文した場合" do
    before do
      threads = []
      threads << Thread.new do
        ActiveRecord::Base.connection_pool.with_connection do
          order = Order.create(user_id: user1.id)
          ordered_list = OrderedList.create(order_id: order.id, item_id: item.id, quantity: 5)
          order.update_total_quantity
        end
      end
      threads << Thread.new do
        ActiveRecord::Base.connection_pool.with_connection do
          order = Order.create(user_id: user2.id)
          ordered_list = OrderedList.create(order_id: order.id, item_id: item.id, quantity: 5)
          order.update_total_quantity
        end
      end
      threads.each(&:join)
    end
    it "その商品の注文数が合計10個になること" do
      expect(item.reload.total_quantity).to eq(5 + 5)
    end
  end
end
