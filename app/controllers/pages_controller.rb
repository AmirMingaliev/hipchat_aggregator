class PagesController < ApplicationController
  def home
  end

  def update
    current_user
  end

  private

  def user_params
    params.require(:user).permit(:ip, room_attributes: %i(name))
  end
end
