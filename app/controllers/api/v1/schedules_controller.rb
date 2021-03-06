module Api::V1
  class SchedulesController < ApiController

    def index
      @schedules = Schedule.all
    end

    def create
      @schedules = Schedule.new
      @schedules.attributes = schedule_params
      save_schedule!
    end

    def update
      @schedules.attributes = schedule_params
      save_schedule!
    end

    private

    def schedule_params
      return {} unless params.has_key?(:schedule)
      params.require(:schedule).permit(:initial_date, :end_date, :initial_hour, :end_hour)
    end

    def save_schedule!
      @schedules.save!
      render :show
    rescue
      render_error(fields: @schedules.errors.messages)
    end
  end
end
