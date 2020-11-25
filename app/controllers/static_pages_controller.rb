class StaticPagesController < ApplicationController
  def home
    @new_products = Product.order_by_create.take(8)
  end

  def about; end

  def contact; end
end
