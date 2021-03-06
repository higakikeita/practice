class ProductsController < ApplicationController
  before_action :set_product, only: [:show,:comment,:edit,:update]
  def index
    @ladies = Product.where(category_id: "1").order(created_at: "DESC").limit(10)
    @men = Product.where(category_id: "2").order(created_at: "DESC").limit(10)
    @home_appliances = Product.where(category_id: "8").order(created_at: "DESC").limit(10)
    @hobbies = Product.where(category_id: "6").order(created_at: "DESC").limit(10)
  end

  def show
    @comment =Comment.new
    @comments =@product.comments
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @comment =Comment.new
    @comments =@product.comments
  end
  def update
    product=Product.includes(:comments).find(params[:id])
    if product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to root_path, notice: '削除しました'
    else
      render :edit
    end
  end

  private
    def product_params
      params.require(:product).permit(:name,:category_id,:price,:explain,:size,:brand_id,:status,:postage,:shipping_date,:prefecture,images_attributes: [:product_image,:_destroy,:id])
    end

    def set_product
      @product = Product.includes(:comments).find(params[:id])
    end
end