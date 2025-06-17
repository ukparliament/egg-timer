module ApplicationHelper

  def csv_icon_link( url, title )
		link_to( content_tag( 'abbr', 'CSV' ), url, :title => title, :class => 'csv' ) + link_to( title , url)
  end
end
