class ApplicationController < ActionController::Base
  include Pundit

  helper_method :current_user_can_edit?
  helper_method :this_is_current_user?

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end

  def this_is_current_user?(model)
    user_signed_in? && model.user == current_user
  end

  def pundit_user
    UserContext.new(current_user, cookies)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
