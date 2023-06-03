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
  end

  def create
    schedule = Schedule.create(schedule_params)
    schedules = Schedule.where(user_id: current_user.id).order(started_at: "DESC")
    render json: { schedules: schedules }
  end

  def schedule_params
    params.permit(:event_name, :started_at, :finished_at, :user_id, :week_id)
  end
end
