require 'order'
require 'menu'
describe Order do
  subject(:order) { described_class.new }
  let(:menu) { double(:menu) }

  let(:menu_items) do
    {
      Lasagne: 12,
      Risotto: 8,
      Carbonara: 10
    }
  end 
  
  context '#see_menu' do
    it 'allows the customer to see the menu items' do
      expect(order.see_menu).to include menu_items
    end 
  end 

  context '#place_order' do
    it 'allows the customer to select dishes off the menu' do
      allow(menu).to receive(:dish?) { true }
      order.place_order("Carbonara", 1)
      expect(order.selection).to eq({ :Carbonara => 1 })
    end
    it 'only allows selection of available menu dishes' do
      allow(menu).to receive(:dish?).with(:Arancini) { false }
      expect { order.place_order(:Arancini, 3) }.to raise_error "Arancini is not on the menu today"
    end 
  end 

  context '#total' do
    it 'calculates the order total' do
      allow(menu).to receive(:dish?) { true }
      order.place_order("Lasagne", 1)
      order.place_order("Risotto", 2)
      total = 28
      expect(order.total).to eq("Your order total is: £#{total}")
    end 
  end 
end 
