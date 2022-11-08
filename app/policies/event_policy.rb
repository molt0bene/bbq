class EventPolicy < ApplicationPolicy
  # просматривать могут только с пинкодом, если он есть
  def show?
    @record.pincode.blank? || user_is_an_owner? || (@record.pincode_valid?(@user.cookies["events_#{@record.id}_pincode"]) if @user.present?)
  end

  # редактировать и удалять может только автор
  def edit?
    user_is_an_owner?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def user_is_an_owner?
    @user.present? && (@user.user == @record.user)
  end
end
