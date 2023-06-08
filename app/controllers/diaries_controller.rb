class DiariesController < ApplicationController
  def index
    @diaries = Diary.where(user_id: current_user.id)
  end

  def new
    @diary = Diary.new
    @user = User.find(current_user.id)
  end

  def create
    diary = Diary.create(diary_params)
  @user = User.find(current_user.id)
    if diary.save
      redirect_to user_schedules_path(@user)
    else
      render :new
    end
  end

  def show
    @diary = Diary.find(params[:id])
  end

  private
  def diary_params
    params.require(:diary).permit(:disliked, :liked, :target, :date).merge(user_id: current_user.id)
  end

end
