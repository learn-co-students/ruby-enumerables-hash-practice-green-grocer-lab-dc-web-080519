require 'pry'

def consolidate_cart(cart)
  myCart = {}
  cart.each do |item|
    item.each do |key, value|
    if myCart.include?(key)
      myCart[key][:count] += 1
    else
        myCart[key] = value
        myCart[key][:count] = 1
    end
  end
  end
  myCart
end

def apply_coupons(cart, coupons)
  if coupons == []
    cart
  end
  
  coupons.each do |coupon|
      couponItemName = coupon[:item]
        if cart.include?(couponItemName)
          if cart[couponItemName][:count] >= coupon[:num]
            couponItemKey = "#{coupon[:item]} W/COUPON"
            if cart.include?(couponItemKey)
              cart[couponItemName][:count] -= coupon[:num]
              cart[couponItemKey][:count] += coupon[:num]
            else
              couponPrice = (coupon[:cost]) / (coupon[:num])
              couponClearance = cart[couponItemName][:clearance]
              couponCount = coupon[:num]
              cart[couponItemKey] = {:price => couponPrice, :clearance => couponClearance, :count => couponCount}
              cart[couponItemName][:count] -= couponCount
            end
          end
        end
  end
  cart
end

# {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}} CART
# [{:item=>"AVOCADO", :num=>2, :cost=>5.0}] COUPONS

def apply_clearance(cart)
  cart.each do |item|
    if item[1][:clearance] == true
      item[1][:price] = item[1][:price] - (item[1][:price] /= 5)
      cart
    else
      cart
    end
  end
end


# def checkout(cart, coupons)
#   consol_cart = consolidate_cart(cart)
#   cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
#   cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

#   total = 0.0
#   cart_with_discounts_applied.keys.each do |item|
#     binding.pry
#     total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
#   end
#   # total > 100.00 ? (total * 0.90).round : total
# end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(cons_cart, coupons)
  clearance_cart = apply_clearance(coup_cart)

  cart_total = 0
  clearance_cart.each do |item, value|
    cart_total += clearance_cart[item][:price] * clearance_cart[item][:count]
  end
  if cart_total > 100
    cart_total = (cart_total * 0.9)
  end
  cart_total
end

# [{"BEETS"=>{:price=>2.5, :clearance=>false, :count=>1}}]
