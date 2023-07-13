class HolidaysController < ApplicationController
  before_action :authenticate_hr, except: %i[index]
  before_action :find_holiday, only: %i[show update]
  
  def index
    holidays = Holiday.all
    render json: holidays
  end

  def create
    holiday = Holiday.new(holiday_params)
    if holiday.save
      render json: holiday
    else
      render json: holiday.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @holiday
  end

  def update
    if @holiday.update(holiday_params)
      render json: @holiday
    else
      render json: @holiday.errors
    end
  end

  private

  def holiday_params
    params.permit(:name, :date)
  end

  def find_holiday
    @holiday = Holiday.find(params[:id])
  rescue Exception => e
    render json: { errors: 'Id Not Found' }
  end
end
