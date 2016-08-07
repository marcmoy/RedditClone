module ApplicationHelper

  def user_owned?(instance)
    return false if current_user.nil?
    current_user.id == instance.user_id
  end

  def auth_token_helper
    '<input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">'.html_safe
  end

end
