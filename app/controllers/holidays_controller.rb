class HolidaysController < ApplicationController
  before_action :authenticate_hr, except: [:index]

  def index
    @holidays = Holiday.all
    if @events.nil?
      render json: {message: "No Entries !!!"}
    else
      render json: @holidays, status: :see_others
    end
  end

  def create
    begin
      @holiday = Holiday.new(holiday_params)
      if @holiday.save
        render json: @holiday
      else
        render json: @holiday.errors, status: :unprocessable_entity
      end
    rescue
      render json: {message: 'Empty Params'}
    end
  end

  def show
    @holiday = Event.find(params[:id])
    render json: @holiday  
  end

  def destroy
    @holiday = Event.find(params[:id])
    @holiday.destroy
  end

  private
    def holiday_params
      params.permit(:name, :date)
    end
end
  