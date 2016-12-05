module ApplicationHelper

  def is_admin?
    if user_signed_in? && current_user.admin?
      return true
    else
      return false
    end
  end
end
