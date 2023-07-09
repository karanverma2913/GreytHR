class HolidaysController < ApplicationController

    before_action :authenticate_hr, except: [:index]

    def index
      @holidays = Holiday.all
      render json: @holidays
    end
  
    def create
      @holiday = Holiday.new(holiday_params)
      render json: @holiday
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
  