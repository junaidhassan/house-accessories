# encoding: utf-8
module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.to_s.titleize
    #css_class = column.to_s == sort_column ? "current #{sort_direction}" : nil
    direction = column.to_s == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    params.delete('_')
    sortArrow = column.to_s == sort_column ? (direction == 'asc' ? '▲' : '▼') : nil
    link_to "#{title} #{sortArrow}", params.merge(:sort => column, :direction => direction, :page => nil)#, {:class => css_class}
  end

  def sort_css_class(column)
    #column.to_s == sort_column ? "current #{sort_direction}" : nil
  end

end
