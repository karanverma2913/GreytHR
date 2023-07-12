class EventsController < ApplicationController
  before_action :authenticate_hr, except: %i[index show]
  def index
    events = Event.all
    if events.empty?
      render json: { message: 'No Entries !!!' }
    else
      render json: events, status: :ok
    end
  end

  def show
    event = Event.find(params[:id])
    render json: event, status: :found
  rescue Exception => e
    render json: { error: 'No Entries With This Id' }
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event
    else
      render json: event.errors
    end
  rescue Exception => e
    render json: { message: 'Not Updated or No Id Found' }
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: { message: 'Event Deleted !' }
  rescue
    render json: { message: 'No Event With This Id' }
  end

  private

  def event_params
    params.permit(:name, :description, :date)
  end
end
