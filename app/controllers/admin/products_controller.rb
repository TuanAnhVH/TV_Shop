class Admin::ProductsController < ApplicationController
  before_action :load_product, except: %i(index new create)

  def index
    @products = Product.order_by_update.order_by_create
                       .page(params[:page]).per(Settings.paging.p_10)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.image.attach(params[:product][:image])
    if @product.save
      flash[:info] = t "product.create_notification_success"
      redirect_to admin_products_path
    else
      flash.now[:danger] = t "product.create_notification_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t "product.update_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand_id, :size_id,
                                    :describe, :image)
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t "product.product_not_found"
    redirect_to root_path
  end
end
