class SchedulesController < ApplicationController
  def new
  end

  def create
    schedule = Schedule.create(schedule_params)
    schedules = Schedule.where(user_id: current_user.id).order(started_at: "ASC")
    render json: { schedules: schedules }
  end

  def schedule_params
    params.permit(:event_name, :started_at, :finished_at, :user_id)
  end
end
