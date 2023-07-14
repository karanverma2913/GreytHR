# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_hr, except: %i[index show]
  before_action :find_event, only: %i[show update destroy]
  def index
    render json: Event.all, status: :ok
  end

  def show
    render json: @event, status: :ok
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
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    render json: { message: 'Event deleted !' }, status: :ok
  rescue StandardError
    render json: { errors: 'Not deleted' }, status: :unprocessable_entity
  end

  private

  def event_params
    params.permit(:name, :description, :date)
  end

  def find_event
    @event = Event.find(params[:id])
  rescue StandardError
    render json: { errors: 'Not Found' }, status: :unprocessable_entity
  end
end
