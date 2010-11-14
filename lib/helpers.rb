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
  @item.path =~ /#{name.downcase}/ ? "<span class='active'>#{name}</span>" : link_to(name, url)
end