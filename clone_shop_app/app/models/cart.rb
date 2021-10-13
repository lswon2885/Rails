class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :pack
  
  
  def verified_save
  
    # cart = self
    sample_carts = user.carts
    # current_user = cart.user #=>  User.find(cart.user_id)
    
    present_cart = sample_carts.find_by(pack_id: pack_id)
  
    if present_cart.present?
      sum_quantity = present_cart.quantity + quantity.to_i
  
      result = present_cart.update(
        quantity: sum_quantity
      )
    else
      save
  end
  end
end