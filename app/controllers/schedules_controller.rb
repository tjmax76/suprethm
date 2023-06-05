class SchedulesController < ApplicationController
  def index
    if params[:week_id]
      schedules = Schedule.where(user_id: current_user.id, week_id: params[:week_id]).order(started_at: "DESC")
      user = User.find(current_user.id)
      week = Week.find(params[:week_id])
      render json: { schedules: schedules, user: user, week: week }
    end
  end
  
  def new
    @schedule = Schedule.new
    @user = User.find(current_user.id)
  end

  def create
    @schedule = Schedule.create(schedule_params)
    @user = User.find(current_user.id)
    schedules = Schedule.where(user_id: current_user.id).order(started_at: "DESC")
    render json: { schedules: schedules }
  end

  def destroy
    schedule = Schedule.find(params[:id])
    week = Week.find(schedule.week_id)
    user = User.find(schedule.user_id)
    schedule.destroy
    schedules = Schedule.where(user_id: current_user.id).order(started_at: "DESC")
    render json: { schedules: schedules, user: user, week: week }
  end

  def schedule_params
    params.require(:schedule).permit(:event_name, :started_at, :finished_at, :week_id).merge(user_id: current_user.id)
  end
end
