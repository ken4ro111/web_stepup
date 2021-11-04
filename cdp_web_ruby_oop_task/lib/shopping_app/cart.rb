require_relative "item_manager"
require_relative "./ownable.rb"

class Cart
  include ItemManager
  include Ownable

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    return if self.owner.wallet.balance < total_amount

    items.each do |item|
      item.owner.wallet.deposit(total_amount)
      self.owner.wallet.withdraw(total_amount)
      item.owner = self.owner
    end

    @items = []
  end

end
