module ApplicationHelper
  def redcloth(text)
    raw RedCloth.new(text).to_html
  end
  
  def paginate(list)
    will_paginate(list, :previous_label => '&laquo; Previous', :next_label => 'Next &raquo;', :class => 'digg_pagination')
  end
end
