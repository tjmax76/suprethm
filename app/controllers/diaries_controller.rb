class DiariesController < ApplicationController
  def index
    @diaries = Diary.where(user_id: current_user.id).order(date: "DESC")
  end

  def new
    @diary = Diary.new
    @user = User.find(current_user.id)
  end

  def create
    @diary = Diary.create(diary_params)
    @diary.date = Date.today
    @user = User.find(current_user.id)
    if @diary.save
      redirect_to user_diary_path(user_id: @user.id, id: @diary.id)
    else
      render :new
    end
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = Diary.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update 
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to user_diary_path(user_id: @user.id, id: @diary.id)
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to user_diaries_path(@user)
  end

  private
  def diary_params
    params.require(:diary).permit(:disliked, :liked, :target).merge(user_id: current_user.id)
  end

end
