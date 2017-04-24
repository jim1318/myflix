class CategoriesController < ApplicationController

  def show
    @videos = Video.where(category_id: params[:id])
  end

end