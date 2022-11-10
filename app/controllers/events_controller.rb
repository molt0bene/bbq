class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, except: %i[index new create]

  after_action :verify_authorized, only: %i[edit update destroy show]

  def index
    @events = Event.all
  end

  def show
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    authorize @event

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])

  rescue Pundit::NotAuthorizedError
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
    render 'password_form'
  end

  def new
    @event = current_user.events.build
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.created') }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.updated') }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @event
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: I18n.t('controllers.events.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :address, :datetime, :description, :photo, :pincode)
    end
end
