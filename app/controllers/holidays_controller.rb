class HolidaysController < ApiController
  before_action :authenticate_hr, only: %i[create update]
  before_action :find_holiday, only: %i[show update]
  before_action :authenticate, only: %i[index show]

  def index
    holiday = Holiday.all
    arr = []
    holiday.each do |i|
      if i.date.year == params[:year].to_i
        arr.push(i)
      end
    end
    render json: arr, status: :ok
  end

  def create
    holiday = Holiday.new(holiday_params)
    if holiday.save
      render json: holiday, status: :created
    else
      render json: holiday.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: @holiday, status: :ok
  end

  def update
    if @holiday.update(holiday_params)
      render json: @holiday, status: :ok
    else
      render json: @holiday.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def holiday_params
    params.permit(:name, :date)
  end

  def find_holiday
    @holiday = Holiday.find(params[:id])
  rescue StandardError
    render json: { errors: 'Not Found' }, staus: :not_found
  end
end
