class PagesController < ApplicationController
  def home
    current_user.rooms.build if current_user.rooms.blank?
  end

  def update
    current_user.update(user_params)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:ip, rooms_attributes: %i(id name))
  end
end
