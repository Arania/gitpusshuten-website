include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Breadcrumbs
include Nanoc3::Helpers::Capturing
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::HTMLEscape
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Text
include Nanoc3::Helpers::XMLSitemap

def image_tag(url, options = {})
  html =  "<img src=\"/images/#{url}\" "
  html += options[:title] ? "title=\"#{options[:title]}\" " : ""
  html += options[:alt] ? "alt=\"#{options[:alt]}\"" : ""
  html += "/>"
  html
end

def custom_link_to(name, url)
  if @item.path =~ /(#{name.downcase})/ or (@item.path == "/" and name.downcase == "about")
    "<span class='active'>#{name}</span>"
  else
    link_to(name, url)
  end
end

def find_and_sort_updates(items)
  require 'date'
  
  menu_items = []
  items.each do |item|
    if item.identifier =~ /\/updates\/.+\//
      menu_items << item
    end
  end  
  
  menu_items.sort_by do |a|
    time = a[:date]
    time.is_a?(String) ? Date.parse(time) : time
  end.reverse
end