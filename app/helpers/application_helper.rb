module ApplicationHelper
  def short_url(code)
    "#{root_url}#{code}"
  end
end
