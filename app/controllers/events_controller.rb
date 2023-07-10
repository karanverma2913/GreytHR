class EventsController < ApplicationController
  before_action :authenticate_hr, except: [:index, :show]
  def index
    @events = Event.all
    if @events.nil?
      render json: {message: "No Entries !!!"}
    else
      render json: @events, status: :ok
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    if @event.nil?
      render json: {message: "No Entries !!!"}
    else
      render json: @event, status: :found
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      @event = Event.find(params[:id])
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors#, status: :not_modified
      end
    rescue
      render json: {message: 'Not Updated'}
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if @event.nil? 
      render json: {message: 'No Event With This Id'}            
    else
      @event.destroy
      render json: {message: 'Event Deleted !'}
    end
  end

  private
    def event_params
      params.permit(:name, :description, :date)
    end
  end
  
  