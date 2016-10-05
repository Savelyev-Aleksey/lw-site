module ApplicationHelper
  def current_path?(test_path)
    return true if request.path == test_path
    false
  end
end
