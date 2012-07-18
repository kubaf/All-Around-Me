module PagesHelper

  def full_title(page_title)
    base_title = "MultiRate.me"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def nav_class(link,cssclass=nil)
    cssclass.nil? ? retclass = "" : retclass = " "+cssclass
    if request.path == link
      retclass = " class='active#{retclass}' " 
    else
      retclass = " class=#{retclass}"
    end
    return retclass
  end
  
  
end
