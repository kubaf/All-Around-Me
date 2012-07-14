module ApplicationHelper
  def full_title(page_title)
    base_title = "MultiRate.me"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def nav_class(link)
    return " class='active' " if request.path == link
  end
end
