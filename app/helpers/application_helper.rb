module ApplicationHelper
  def title
	base_title = "Sample APP"
    if @title.nil? 
	  base_title
 	else
	  "#{base_title} | #{@title}"	
	end
  end

  def logo_path
    "tutorial.png"
  end
end
