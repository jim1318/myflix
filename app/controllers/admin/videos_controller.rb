class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params)
    if @video.save
      flash[:success] = "Video '#{@video.title}' Successfully Saved"
      redirect_to new_admin_video_path
    else
      flash[:danger] = "Video not saved :("
      render :new
    end
  end

  private

  def require_admin
    if !current_user.admin?
      flash[:danger] = "You are not authorized to do that"
      redirect_to home_path
    end
  end

  def video_params
    params.require(:video).permit!
  end



end