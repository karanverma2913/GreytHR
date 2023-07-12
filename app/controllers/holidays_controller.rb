class HolidaysController < ApplicationController
  before_action :authenticate_hr, except: [:index]

  def index
    holidays = Holiday.all
    if holidays.empty?
      render json: { message: 'No Entries !!!' }
    else
      render json: holidays
    end
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
    holiday = Holiday.find(params[:id])
    render json: holiday
  rescue Exception => e
    render json: { message: 'Invalid Id' }
  end

  def update
    holiday = Holiday.find(params[:id])
    if holiday.update(holiday_params)
      render json: holiday
    else
      render json: holiday.errors
    end
  rescue Exception => errors
    render json: { error: 'Not Updated or No Id Found' }
  end

  private

  def holiday_params
    params.permit(:name, :date)
  end
end
