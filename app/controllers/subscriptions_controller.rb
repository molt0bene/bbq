class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_subscription, only: %i[ destroy ]

  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully created." }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_subscription
      @subscription = @event.subscriptions.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end


    def subscription_params
      params.fetch(:subscription, {}).permit(:user_email, :user_name)
    end
end
