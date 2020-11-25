class ProductsController < ApplicationController
  before_action :load_product, only: [:show]

  def index
    @per_page = Settings.paging.p_8
    @products = Product.order_by_create.page(params[:page]).per(@per_page)
  end

  def show
    @comments = @product.feed.page(params[:page]).per(Settings.paging.p_5)
    @comment = @product.comments.build
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "controllers.products_controller.product_not_found"
    redirect_to root_path
  end
end
