module ApplicationHelper

  def item_to_currency(item)
    number_to_currency(item.quantity * item.pack.price)
  end

  def cart_to_currency(cart)
    number_to_currency(cart.pack.price * cart.quantity)
  end
end
