class Admin::BrandsController < AdminController
  before_action :load_brand, only: [:edit, :update]

  def index
    @per_page = Settings.paging.p_10
    @brands = Brand.order_name_asc.page(params[:page]).per(@per_page)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new brand_params
    if @brand.save
      flash[:success] = t "brands.brand_created"
      redirect_to admin_brands_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      flash[:success] = t "brands.brand_updated"
      redirect_to admin_brands_path
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

  def load_brand
    @brand = Brand.find_by(id: params[:id])
    return if @brand

    flash[:warning] = t "brands.brand_not_found"
    redirect_to brands_path
  end
end
