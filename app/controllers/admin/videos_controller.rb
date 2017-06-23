class Admin::VideosController < AdminsController
  before_filter :require_user

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

  def video_params
    params.require(:video).permit!
  end



end