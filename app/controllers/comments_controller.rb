class CommentsController < ApplicationController
  before_action :check_login
  before_action :load_product

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = t "controllers.comments_controller.comment_created"
    else
      flash[:danger] = t "controllers.comments_controller.comment_fail"
    end
    redirect_to @product
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :product_id)
  end

  def load_product
    @product = Product.find_by(id: params[:comment][:product_id])
    return if @product

    flash[:danger] = t "controllers.products_controller.product_not_found"
    redirect_to root_path
  end
end
