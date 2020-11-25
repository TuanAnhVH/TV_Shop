module ProductsHelper
  def load_brands
    Brand.select(:id, :name)
  end

  def load_sizes
    Size.select(:id, :name)
  end
end
