class HolidaysController < ApplicationController
  before_action :authenticate_hr, except: [:index]

  def index
    holidays = Holiday.all
    if holidays.nil?
      render json: {message: "No Entries !!!"}
    else
      render json: @holidays
    end
  end

  def create
    begin
      holiday = Holiday.new(holiday_params)
      if holiday.save
        render json: @holiday
      else
        render json: @holiday.errors, status: :unprocessable_entity
      end
    rescue
      render json: {message: 'Empty Params'}
    end
  end

  def show
    begin
      holiday = Holiday.find(params[:id])
      render json: holiday  
    rescue
      render json: {message: "Invalid Id"}
    end
  end

  def update
    begin
      holiday = Holiday.find(params[:id])
      if holiday.update(holiday_params)
        render json: holiday
      else
        render json: holiday.errors
      end
    rescue
      render json: {error: 'Not Updated or No Id Found'}
    end
  end


  private
    def holiday_params
      params.permit(:name, :date)
    end
end
  