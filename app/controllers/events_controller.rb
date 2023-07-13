class EventsController < ApplicationController
  before_action :authenticate_hr, except: %i[index show]
  before_action :find_event, only: %i[show update destroy]
  def index
    events = Event.all
    render json: events, status: :ok
  end

  def show
    render json: @event, status: :found
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @event.update(event_params)
    render json: @event
  end

  def destroy
    @event.destroy
    render json: { message: 'Event Deleted !' }
  end

  private

  def event_params
    params.permit(:name, :description, :date)
  end

  def find_event
    @event = Event.find(params[:id])
  rescue Exception => e
    render json: { errors: 'Id Not Found' }
  end
end
