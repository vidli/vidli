module ApplicationHelper
  def redcloth(text)
    raw RedCloth.new(text).to_html
  end
  
  def paginate(list)
    will_paginate(list, :previous_label => '&laquo; Previous', :next_label => 'Next &raquo;', :class => 'digg_pagination')
  end
  
  def layout_meta_title
    (content_for(:title) + " - " if !content_for(:title).empty?).to_s + VidliConfig.site_name
  end
  
  def date_full(date)
    date.in_time_zone.strftime("%B %d, %Y at %I:%M%p")
  end
end
