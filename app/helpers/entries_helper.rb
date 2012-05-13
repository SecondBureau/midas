module EntriesHelper
  def table_tag (table, height, params = {})
    params[:format] ||= :json
    path = entries_path({:format => 'json', :table => table}.merge params)
    content_tag(:div, :'data-table' => raw(path), :style => "height: #{height}px;") do
      image_tag('spinner.gif', :size => '100x100', :class => 'spinner')
    end
  end
end
