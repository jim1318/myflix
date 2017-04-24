class PagesController < ApplicationController
  def front
    redirect_to home_path it current_user
  end
end