#Method
# 1. double the line items
# 2.  apply discount to half of doubled line items: == line items of origin counts
#
# Partitions the items and returns the items that are to be discounted.
#
# Arguments
# ---------
#
# * cart
#   The cart to which split items will be added (typically Input.cart).
#
# * line_items
#   The selected items that are applicable for the campaign.
#
def partition(cart, line_items)
  sorted_items = line_items.sort_by{|line_item| 

line_item.variant.price}.reverse
  discounted_items = []
  sorted_items.each do |line_item|
    count = Integer(line_item.quantity / 2)
    discounted_item = line_item.split(take: count)
    position = cart.line_items.find_index(line_item)
    cart.line_items.insert(position + 1, discounted_item)
    discounted_items.push(discounted_item)
  end
  discounted_items
end

eligible_items = Input.cart.line_items.select do |line_item|
  product = line_item.variant.product
  !product.gift_card? &&
end

#double line items with price and quantity
eligible_items.each do |el|
  el.instance_variable_set(:@quantity, el.quantity * 2)
  el.instance_variable_set(:@line_price, el.line_price * 2)
end

#about half line products, apply discounts
discounted_line_items = partition(Input.cart, eligible_items)
discounted_line_items.each do |line_item|
 puts(line_item.quantity)
 line_item.change_line_price(Money.zero, message: "Buy one, get one 

free")
end

Output.cart = Input.cart
