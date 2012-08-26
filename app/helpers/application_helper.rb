module ApplicationHelper

  def get_full_display(u)
    u.display_name + " ("+u.email+")"
  end

end
