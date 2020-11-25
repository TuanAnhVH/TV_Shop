class PagesController < ApplicationController
  before_action :load_brand, only: [:filter_via_brand]

  def search
    @per_page = Settings.paging.p_8
    if params[:search].blank?
      flash[:success] = t "controllers.pages_controller.empty"
      redirect_to root_path
    else
      @count_results = Product.search_by_name(params[:search])
      @results = @count_results.page(params[:page]).per(@per_page)
    end
  end

  def filter_via_brand
    per_page = Settings.paging.p_8
    @results = @brand.products.order_by_create.page(params[:page]).per(per_page)
  end

  private

  def load_brand
    @brand = Brand.find_by(id: params[:id])
    return if @brand

    flash[:danger] = t "brands.brand_not_found"
    redirect_to root_path
  end
end
