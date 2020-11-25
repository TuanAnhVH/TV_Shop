class AdminController < ApplicationController
  before_action :check_login
  before_action :require_admin

  private

  def require_admin
    return if is_admin?

    flash[:danger] = t "controllers.admin_controller.not_have_access"
    redirect_to root_path
  end
end
