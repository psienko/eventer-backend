module Api
  module V1
    class EventsController < ApiController
      before_action :set_event, only: [:show, :update]

      def index
        @events = Event.all
        render json: @events
      end

      def show
        render json: @event
      end

      def create
        @event = Event.new(event_params)
        status = @event.save ? :created : :unprocessable_entity
        render json: @event, status: status
      end

      def update
        status = @event.update(event_params) ? :ok : :unprocessable_entity
        render json: @event, status: status
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      def event_params
        params = ActionController::Parameters.new(json)
        params.permit(:event_type, :name, :start_at, :end_at, :place, :status)
      end
    end
  end
end
