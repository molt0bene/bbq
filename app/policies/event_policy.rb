class EventPolicy < ApplicationPolicy
  # просматривать могут только с пинкодом, если он есть
  def show?
    @record.pincode.blank? || (@user.present? && @user == @record.user) || @record.pincode_valid?(user.cookies["events_#{@record.id}_pincode"]) if user.present?
  end

  # редактировать и удалять может только автор
  def edit?
    @user.present? && @record.user == @user
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
end
