module ApplicationHelper

  def is_admin?
    if user_signed_in? && current_user.admin?
      return true
    else
      return false
    end
  end

  def progress_bar_class(score)
    if score >= 20
      return 'progress-bar progress-bar-success'
    else
      return 'progress-bar progress-bar-danger'
    end
  end
end
