class UsersController < ApplicationController
  before_action :load_user, :correct_user

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "users.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :address, :phone, :password, :password_confirmation)
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t "users.refuse_action"
    redirect_to root_path
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:warning] = t "users.user_not_found"
    redirect_to root_path
  end
end
