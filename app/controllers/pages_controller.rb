class PagesController < ApplicationController
  def home
  end

  def update
    current_user.update(user_params)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:ip, rooms_attributes: [:id, :name, :_destroy])
  end
end
