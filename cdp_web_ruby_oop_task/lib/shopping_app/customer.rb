require_relative "user"
require_relative "cart"

class Customer < User
  attr_reader :cart

  def initialize(name)
    super(name)
    @cart = Cart.new(self) # Customerインスタンスは生成されると、自身をオーナーとするカートを持ちます。
  end

end
